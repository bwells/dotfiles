function __claude_find_preview --description 'Preview pane for claude-find: title, context, prompts matching the query, then every prompt'
    set -l sid $argv[1]
    set -l query $argv[2]
    set -l bold (set_color --bold)
    set -l dim (set_color brblack)
    set -l cyan (set_color cyan)
    set -l off (set_color normal)

    set -l transcript ~/.claude/projects/*/$sid.jsonl
    set -l t $transcript[1]
    # ripgrep keeps this instant on 70MB transcripts.
    set -l g rg -o --no-filename --no-line-number
    command -q rg; or set g command grep -oE

    # Title: the latest /rename, else the latest auto-generated title.
    set -l title ($g '"customTitle":"([^"\\\\]|\\\\.)*"' $t | tail -1 | string replace -r '^"customTitle":' '' | jq -r .)
    test -z "$title"; and set title ($g '"aiTitle":"([^"\\\\]|\\\\.)*"' $t | tail -1 | string replace -r '^"aiTitle":' '' | jq -r .)
    set -l branch ($g '"gitBranch":"[^"]*"' $t | tail -1 | string replace -r '^"gitBranch":"(.*)"$' '$1')
    set -l prs ($g '"prUrl":"[^"]*"' $t | string replace -r '^.*github\.com/[^/]+/([^/]+)/pull/([0-9]+)"$' '$1#$2' | sort -u)

    set -l prompts (jq -r --arg sid $sid '
        select(.sessionId == $sid)
        | "\(.timestamp / 1000 | strflocaltime("%b %d %H:%M"))\t\(.display | gsub("[[:space:]]+"; " "))"
    ' ~/.claude/history.jsonl)
    set -l project (jq -r --arg sid $sid 'select(.sessionId == $sid) | .project' ~/.claude/history.jsonl | head -1 | string replace $HOME '~')

    test -n "$title"; and echo $bold$title$off
    echo $cyan$project$off$dim"  ·  "(count $prompts)" prompts  ·  "(du -h $t | string split -f1 \t | string trim)$off
    test -n "$branch"; and test "$branch" != HEAD; and echo $dim"branch  "$off$branch
    test -n "$prs"; and echo $dim"PRs     "$off(string join ', ' $prs)
    echo

    # Highlight each query term (fzf --exact terms; drop fzf operators and negations).
    set -l terms
    for w in (string split -n ' ' -- $query)
        string match -q -- '!*' $w; and continue
        set w (string trim -c "'^\$|" -- $w)
        test -n "$w"; and set -a terms (string escape --style=regex -- $w)
    end
    set -l rx (string join '|' -- $terms)

    set -l tab \t
    set -l fmt "s/^([^$tab]*)$tab/$dim\\1$off  /"
    if test -n "$rx"
        set -l hits (printf '%s\n' $prompts | grep -iE -- $rx)
        if set -q hits[1]
            echo $bold"Matching prompts"$off
            printf '%s\n' $hits | sed -E $fmt | env GREP_COLORS='mt=01;33' grep --color=always -iE -- $rx
            echo
        end
    end
    echo $bold"All prompts"$off
    printf '%s\n' $prompts | sed -E $fmt
    echo
    echo $dim$sid$off
end
