function __claude_find_open_tab --description 'claude-find ctrl-o: resume a session in a new, focused Rex tab; prints the new fzf header'
    set -l sid $argv[1]
    set -l dir (__claude_session_dir $sid; or echo $argv[2])
    set -l keys 'enter resume here · ctrl-o new Rex tab · ctrl-y copy id · tab mark · ctrl-e export · ctrl-s send'
    set -l red (set_color red)
    set -l green (set_color green)
    set -l off (set_color normal)

    if not set -q REX_SESSION
        echo $keys
        echo $red"not inside Rex — use enter to resume here"$off
        return
    end
    if not test -d $dir
        echo $keys
        echo $red"$dir no longer exists (deleted worktree or tmp scratchpad?)"$off
        return
    end

    # Name the tab after the session's title when it has one.
    set -l label (path basename $dir)
    set -l t ~/.claude/projects/*/$sid.jsonl
    if set -q t[1]; and command -q rg
        set -l title (rg -o --no-filename --no-line-number '"(customTitle|aiTitle)":"[^"]*"' $t[1] | tail -1 | string replace -r '^"[a-zA-Z]+":"(.*)"$' '$1')
        test -n "$title"; and set label (string shorten -m 30 -- $title)
    end

    echo $keys
    set -l win (rex window new -s $REX_SESSION -c $dir --json $label -- fish -lc "claude --resume $sid" 2>/dev/null | jq -r .window_id)
    if test -z "$win"
        echo $red"rex couldn't open a tab for $sid"$off
        return
    end
    # The server's "active" tab doesn't move the app's view; ask the app (client) to show it.
    # Uses REX_CLIENT if set, else the one connected app. Needs Remote Control on in the app.
    set -l err (rex do session.select session_id=$REX_SESSION window_id=$win 2>&1 >/dev/null)
    if test $status -eq 0
        echo $green"opened “$label” in a new tab"$off
    else
        echo $green"opened “$label” in a new tab"$off$red" — couldn't switch to it: "(string join ' ' -- $err | string shorten -m 80)$off
    end
end
