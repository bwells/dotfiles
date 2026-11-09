function claude-find --description 'Fuzzy-find any Claude Code session by its prompts and resume it in the right directory'
    # Index: ~/.claude/history.jsonl records every prompt with its project dir and session id,
    # so one search covers sessions from every directory. Titles come from the transcripts.
    #   enter   cd to the session's directory and `claude --resume` it here
    #   ctrl-o  resume it in a new Rex tab and switch to it; the finder stays open here
    #   ctrl-y  copy the session id
    #   tab     mark sessions; ctrl-e exports the marked ones (or the current one) with claude-export,
    #           ctrl-s sends them to another Rex host with claude-send
    set -l hist ~/.claude/history.jsonl
    if not test -r $hist
        echo "claude-find: $hist not found" >&2
        return 1
    end

    set -l transcripts ~/.claude/projects/*/*.jsonl
    # "<project folder>/<session id>" per transcript; the folder is the directory resume needs.
    set -l live (string replace -r '^.*/projects/(.*)\.jsonl$' '$1' $transcripts)
    # "<path>:<title record>" lines; the last of each kind per session wins.
    # ripgrep scans the ~1.5GB of transcripts in ~50ms; macOS grep takes several seconds.
    set -l scan rg --no-heading --with-filename --no-line-number
    command -q rg; or set scan command grep -H
    set -l titles ($scan -F -e '"type":"ai-title"' -e '"type":"custom-title"' $transcripts 2>/dev/null)
    # Session ids currently open in a running claude process.
    set -l running
    for f in ~/.claude/sessions/*.json
        set -l info (jq -r '"\(.pid) \(.sessionId)"' $f 2>/dev/null | string split ' ')
        if test (count $info) -eq 2; and kill -0 $info[1] 2>/dev/null
            set -a running $info[2]
        end
    end

    set -l picked (
        jq -rn --rawfile live (printf '%s\n' $live | psub) \
               --rawfile titles (printf '%s\n' $titles | psub) \
               --rawfile running (printf '%s\n' $running | psub) \
               --arg home $HOME --argjson now (date +%s) '
            def lines: split("\n") | map(select(. != ""));
            def fit($n): if length > $n then .[0:$n-1] + "…" else . + (" " * ($n - length)) end;
            def dim: "\u001b[2m" + . + "\u001b[0m";
            def age: ($now - . / 1000) as $s
                | if $s < 3600 then "\($s / 60 | floor)m"
                  elif $s < 86400 then "\($s / 3600 | floor)h"
                  elif $s < 86400 * 14 then "\($s / 86400 | floor)d"
                  else "\($s / 604800 | floor)w" end;
            def plabel: if test("/\\\\.claude/worktrees/")
                    then capture("(?<repo>[^/]+)/\\\\.claude/worktrees/(?<wt>[^/]+)") | "\(.repo)⎇\(.wt)"
                  elif test("^(/private)?/tmp/claude-") then "tmp:" + (split("/") | last)
                  elif startswith($home + "/workspace/") then .[($home + "/workspace/" | length):]
                  else sub("^" + $home; "~") end;

            ($live | lines | map(split("/") | {(.[1]): .[0]}) | add // {}) as $folder
            | ($running | lines | map({(.): true}) | add // {}) as $run
            | ($titles | lines
                | map(capture("/(?<sid>[^/]+)\\\\.jsonl:(?<j>\\\\{.*)$") | .sid as $sid
                      | (.j | fromjson? // empty)
                      | {sid: $sid, k: (if .type == "custom-title" then "customTitle" else "aiTitle" end),
                         v: (.customTitle // .aiTitle)}
                      | select(.v != null))
                | reduce .[] as $t ({}; .[$t.sid][$t.k] = $t.v)) as $title
            | [inputs | select(.sessionId != null and $folder[.sessionId])]
            | group_by(.sessionId)
            | map(sort_by(.timestamp)
                  | .[0].sessionId as $sid
                  # A session can span directories; resume from the one its transcript is filed under.
                  | ((map(.project) | unique | map(select(gsub("[^A-Za-z0-9]"; "-") == $folder[$sid])) | first)
                     // .[0].project) as $proj
                  | (map(.display | gsub("[[:space:]]+"; " ") | ltrimstr(" "))) as $prompts
                  | ($title[$sid].customTitle // $title[$sid].aiTitle) as $t
                  | {sid: $sid, proj: $proj, ts: .[-1].timestamp, prompts: $prompts,
                     title: ($t // (($prompts | map(select(test("^[/!@]") | not) | select(length >= 15)) | first)
                                    // $prompts[0] | dim))})
            | sort_by(-.ts)[]
            | [ .sid, .proj,
                ((if $run[.sid] then "\u001b[32m●\u001b[0m" else " " end)
                 + " " + (.ts | age | (" " * (3 - length)) + . | dim)
                 + "  " + "\u001b[36m" + (.proj | plabel | fit(26)) + "\u001b[0m"
                 + "  " + .title
                 # Prompts are searchable but pushed far off-screen.
                 + (" " * 500) + (.prompts | map(.[0:300]) | join(" ⏐ "))) ]
            | @tsv' $hist \
        | fzf --ansi --delimiter '\t' --with-nth 3 --exact --no-sort --no-hscroll --ellipsis '' \
              --layout reverse --info inline-right --border none \
              --prompt 'claude ❯ ' --query "$argv" \
              --multi --header 'enter resume here · ctrl-o new Rex tab · ctrl-y copy id · tab mark · ctrl-e export · ctrl-s send' \
              --with-shell 'fish -c' \
              --preview '__claude_find_preview {1} {q}' \
              --preview-window 'right,50%,wrap,border-left,<160(down,55%,wrap,border-top)' \
              --bind 'ctrl-o:transform-header(__claude_find_open_tab {1} {2})' \
              --expect 'ctrl-y,ctrl-e,ctrl-s'
    )
    or return

    set -l key $picked[1]
    if test "$key" = ctrl-e
        claude-export (string split -f1 \t -- $picked[2..])
        return
    end
    if test "$key" = ctrl-s
        claude-send (string split -f1 \t -- $picked[2..])
        return
    end
    set -l fields (string split \t -- $picked[2])
    set -l sid $fields[1]
    set -l dir (__claude_session_dir $sid; or echo $fields[2])

    if test "$key" = ctrl-y
        printf '%s' $sid | pbcopy
        echo "copied $sid"
        return
    end

    if not test -d $dir
        echo "claude-find: directory $dir no longer exists (deleted worktree or tmp scratchpad?)." >&2
        echo "Transcript: "(path resolve ~/.claude/projects/*/$sid.jsonl) >&2
        return 1
    end

    cd $dir; and claude --resume $sid
end
