function claude-send --description 'Send Claude Code sessions to another Rex host and resume them there in Rex tabs'
    # Usage: claude-send [-H REX_HOST] [--ssh SSH_TARGET] [-n] SESSION_ID...
    # Usually called from claude-find: tab to mark sessions, ctrl-s to send them.
    #
    #   1. claude-export bundles the sessions here
    #   2. scp copies the bundle to ~/claude-inbox on the other machine
    #   3. claude-import runs there over ssh (needs the same dotfiles there)
    #   4. Rex opens a "claude-sessions" session on that host with one `claude --resume`
    #      tab per session whose directory exists there, and switches that host's app to it
    #
    # REX_HOST defaults to $CLAUDE_SEND_HOST, else you pick from `rex hosts`.
    # SSH_TARGET defaults to the host's Rex address minus "-rex"
    # (https://panoply-rex.<tailnet>.ts.net → panoply.<tailnet>.ts.net).
    argparse 'H/host=' 'ssh=' 'n/dry-run' -- $argv; or return
    if test (count $argv) -eq 0
        echo "usage: claude-send [-H REX_HOST] [--ssh SSH_TARGET] [-n] SESSION_ID..." >&2
        return 1
    end
    set -l bold (set_color --bold)
    set -l dim (set_color brblack)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l off (set_color normal)

    # --- Which machine -------------------------------------------------------------
    set -l host $_flag_host
    test -n "$host"; or set host $CLAUDE_SEND_HOST
    set -l hosts_json (rex hosts --json | string collect)
    if test -z "$host"
        set host (echo $hosts_json | jq -r '.hosts[].host.label' | fzf --height 10 --layout reverse --prompt 'send to ❯ ')
        or return
    end
    set -l endpoint (echo $hosts_json | jq -r --arg h $host '.hosts[] | select(.host.label == $h) | .host.endpoints[0] // empty')
    if test -z "$endpoint"
        echo $red"claude-send: no Rex host labelled \"$host\" (see: rex hosts)"$off >&2
        return 1
    end
    set -l target $_flag_ssh
    test -n "$target"; or set target (string replace -r '^https?://([^.]+)-rex\.' '$1.' -- $endpoint | string replace -r '[:/].*$' '')
    echo "sending "(count $argv)" session(s) to $bold$host$off "$dim"(ssh $target)"$off

    if set -q _flag_dry_run
        echo $dim"dry run: would export, scp to $target:claude-inbox/, run claude-import there, and open Rex tabs on $host"$off
        return
    end

    # Remote commands are fish scripts piped to fish over ssh, so they work even while
    # that Mac's login shell is still zsh.
    set -l rfish /opt/homebrew/bin/fish -l

    # --- Preflight: can we reach it, and is it set up? ------------------------------
    set -l probe (echo 'echo "home=$HOME"; functions -q claude-import; and echo has-import' \
        | ssh -o BatchMode=yes -o ConnectTimeout=8 $target $rfish 2>&1)
    if test $status -ne 0
        echo $red"claude-send: ssh $target failed:"$off >&2
        printf '  %s\n' $probe >&2
        echo $dim"  enable Remote Login on that Mac (System Settings → General → Sharing), check ssh keys"$off >&2
        echo $dim"  and that fish is at /opt/homebrew/bin/fish there (dotfiles' bootstrap.sh), or pass --ssh"$off >&2
        return 1
    end
    # Parse labelled lines: ssh may mix in host-key warnings or a login banner.
    set -l remote_home (string replace -rf '^home=' '' -- $probe)[1]
    if not contains has-import $probe
        echo $red"claude-send: claude-import isn't installed on $target — run dotfiles' bootstrap.sh there first"$off >&2
        return 1
    end

    # --- Export, copy, import ------------------------------------------------------
    set -l bundle (mktemp -d)/claude-sessions-(hostname -s)-(date +%Y%m%d-%H%M%S).tgz
    claude-export -o $bundle $argv; or return
    set -l name (path basename $bundle)
    echo
    echo $dim"copying $name to $target:claude-inbox/"$off
    ssh $target mkdir -p claude-inbox; or return
    scp -q $bundle $target:claude-inbox/; or return
    rm -rf (path dirname $bundle)
    echo
    echo "claude-import ~/claude-inbox/$name" | ssh $target $rfish; or return

    # --- Resume them in Rex on that host ---------------------------------------------
    # Map each session to its directory over there, keep the ones that exist.
    set -l checks
    for sid in $argv
        set -l dir (__claude_session_dir $sid)
        test -n "$dir"; or continue
        set dir (string replace -- $HOME $remote_home $dir)
        set -a checks "test -d "(string escape -- $dir)"; and echo "(string escape -- "$sid $dir")
    end
    set -l ready (printf '%s\n' $checks | ssh $target $rfish)
    if not set -q ready[1]
        echo $dim"no session directories exist on $host yet; clone them as listed above, then use claude-find there"$off
        return
    end

    set -l rsess (rex -S $host new claude-sessions --json | jq -r .session_id)
    if test -z "$rsess"
        echo $red"claude-send: couldn't create a Rex session on $host; sessions are imported, resume them with claude-find there"$off >&2
        return 1
    end
    set -l first_win
    for line in $ready
        set -l sid (string split -f1 ' ' -- $line)
        set -l dir (string split -m1 -f2 ' ' -- $line)
        set -l label (rg -o --no-filename '"(customTitle|aiTitle)":"[^"]*"' ~/.claude/projects/*/$sid.jsonl 2>/dev/null | tail -1 | string replace -r '^"[a-zA-Z]+":"(.*)"$' '$1')
        test -n "$label"; or set label (path basename $dir)
        set -l win (rex -S $host window new -s $rsess -c $dir --focus=false --json (string shorten -m 30 -- $label) -- fish -lc "claude --resume $sid" | jq -r .window_id)
        test -z "$first_win"; and set first_win $win
        echo $green"  ▶ resumed on $host: "$off$label
    end

    # Show it in that host's Rex app, when exactly one app is connected there.
    set -l app (rex -S $host client ls --json | jq -r '[.clients[] | select(.info.kind == "app")] | if length == 1 then .[0].client_id else empty end')
    if test -n "$app"
        rex -S $host -C $app do session.select session_id=$rsess window_id=$first_win >/dev/null 2>&1
        and echo $dim"switched $host's Rex app to the claude-sessions session"$off
    else
        echo $dim"open the claude-sessions session in Rex on $host to see them"$off
    end
end
