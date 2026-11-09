function claude-import --description 'Restore Claude Code sessions from a claude-export bundle, rewriting paths if the home directory changed'
    # Usage: claude-import [-n|--dry-run] bundle.tgz
    # Never overwrites anything that already exists here; safe to run twice.
    argparse 'n/dry-run' -- $argv; or return
    set -l bundle $argv[1]
    if not test -f "$bundle"
        echo "usage: claude-import [-n] bundle.tgz" >&2
        return 1
    end
    set -l cfg ~/.claude
    set -q CLAUDE_CONFIG_DIR; and set cfg $CLAUDE_CONFIG_DIR
    set -l bold (set_color --bold)
    set -l dim (set_color brblack)
    set -l yellow (set_color yellow)
    set -l green (set_color green)
    set -l off (set_color normal)

    set -l stage (mktemp -d)
    tar -xzf $bundle -C $stage; or return
    set -l old (jq -r .home $stage/manifest.json)
    echo "bundle from "(jq -r .host $stage/manifest.json)", exported "(jq -r .exported_at $stage/manifest.json)

    # Home directory changed (different username): rename the encoded project folders and
    # rewrite absolute paths inside every transcript, title and history entry.
    if test "$old" != "$HOME"
        echo "rewriting paths $old → $HOME"
        set -l old_enc (string replace -ra '[^A-Za-z0-9]' '-' -- $old)
        set -l new_enc (string replace -ra '[^A-Za-z0-9]' '-' -- $HOME)
        for d in $stage/projects/*
            set -l name (path basename $d)
            if string match -q -- "$old_enc*" $name
                mv $d $stage/projects/$new_enc(string sub -s (math (string length -- $old_enc) + 1) -- $name)
            end
        end
        find $stage -type f \( -name '*.jsonl' -o -name '*.json' -o -name '*.md' \) -print0 \
            | O=$old N=$HOME xargs -0 perl -pi -e 's/\Q$ENV{O}\E/$ENV{N}/g'
    end

    if set -q _flag_dry_run
        echo $dim"dry run — would copy:"$off
        find $stage/projects $stage/file-history -maxdepth 2 -mindepth 2 2>/dev/null | string replace $stage/ '  '
    else
        mkdir -p $cfg/projects $cfg/file-history
        rsync -a --ignore-existing $stage/projects/ $cfg/projects/
        test -d $stage/file-history; and rsync -a --ignore-existing $stage/file-history/ $cfg/file-history/
        # Prompt history powers claude-find; add entries for sessions this machine doesn't know yet.
        touch $cfg/history.jsonl
        set -l known (jq -r '.sessionId // empty' $cfg/history.jsonl | sort -u)
        jq -c 'select(.sessionId as $s | $ARGS.positional | index($s) | not)' $stage/history.jsonl --args $known >>$cfg/history.jsonl
    end

    # What's needed before each session can be resumed.
    echo
    for row in (jq -c '.sessions[]' $stage/manifest.json)
        set -l title (echo $row | jq -r 'if .title != "" then .title else .sid end')
        set -l proj (echo $row | jq -r .project)
        set -l sid (echo $row | jq -r .sid)
        echo $bold$title$off
        if test -d "$proj"
            echo $green"  ✓ ready: "$off"cd "(string replace $HOME '~' -- $proj)"; and claude --resume $sid"
        else
            set -l remote (echo $row | jq -r .git.remote)
            set -l branch (echo $row | jq -r .git.branch)
            set -l top (echo $row | jq -r .git.toplevel)
            echo $yellow"  ✗ "(string replace $HOME '~' -- $proj)" doesn't exist yet"$off
            if test -n "$remote"
                set -l t (string replace $old $HOME -- $top)
                echo "    git clone $remote $t"(test -n "$branch"; and echo "; and git -C $t switch $branch")
                test "$t" != "$proj"; and echo $dim"    (session ran in a subdirectory/worktree: $proj)"$off
            else
                echo $dim"    create it (or anything at that path) to resume; the conversation itself is restored"$off
            end
        end
    end
    rm -rf $stage
    echo
    echo $dim"claude-find lists the imported sessions"$off
end
