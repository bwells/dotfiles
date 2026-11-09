function claude-export --description 'Bundle Claude Code sessions (transcripts, subagents, file history, prompt history) into a tarball for another machine'
    # Usage: claude-export [-o bundle.tgz] SESSION_ID...
    # Usually called from claude-find: tab to mark sessions, ctrl-e to export them.
    # Restore on the other machine with: claude-import bundle.tgz
    argparse 'o/output=' -- $argv; or return
    if test (count $argv) -eq 0
        echo "usage: claude-export [-o bundle.tgz] SESSION_ID..." >&2
        return 1
    end
    set -l cfg ~/.claude
    set -q CLAUDE_CONFIG_DIR; and set cfg $CLAUDE_CONFIG_DIR
    set -l out $_flag_output
    test -n "$out"; or set out ~/Desktop/claude-sessions-(date +%Y%m%d-%H%M).tgz

    set -l bold (set_color --bold)
    set -l dim (set_color brblack)
    set -l yellow (set_color yellow)
    set -l off (set_color normal)

    set -l stage (mktemp -d)
    set -l files
    set -l entries
    for sid in $argv
        set -l t $cfg/projects/*/$sid.jsonl
        if not set -q t[1]
            echo $yellow"skipping $sid: no transcript on this machine"$off >&2
            continue
        end
        set -l folder (path basename (path dirname $t[1]))
        set -a files projects/$folder/$sid.jsonl
        # Subagent transcripts, saved tool output, custom title.
        test -d $cfg/projects/$folder/$sid; and set -a files projects/$folder/$sid
        # Edit snapshots used by rewind.
        test -d $cfg/file-history/$sid; and set -a files file-history/$sid
        # The project's auto-memory travels with its sessions (never overwrites on import).
        test -d $cfg/projects/$folder/memory; and set -a files projects/$folder/memory

        # The directory resume needs (handles worktrees); fall back to the session's first prompt.
        set -l proj (__claude_session_dir $sid)
        test -n "$proj"; or set proj (jq -r --arg sid $sid 'select(.sessionId == $sid) | .project' $cfg/history.jsonl | head -1)

        set -l title (rg -o --no-filename '"(customTitle|aiTitle)":"[^"]*"' $t[1] | tail -1 | string replace -r '^"[a-zA-Z]+":"(.*)"$' '$1')
        set -l remote ''
        set -l branch ''
        set -l toplevel ''
        set -l dirty 0
        set -l unpushed 0
        if test -d "$proj"; and git -C $proj rev-parse --git-dir >/dev/null 2>&1
            set toplevel (git -C $proj rev-parse --show-toplevel)
            set remote (git -C $proj remote get-url origin 2>/dev/null)
            set branch (git -C $proj branch --show-current)
            set dirty (git -C $proj status --porcelain 2>/dev/null | count)
            set unpushed (git -C $proj rev-list --count '@{u}..HEAD' 2>/dev/null; or echo '?')
        end
        set -l size (du -sh $t[1] (path dirname $t[1])/$sid 2>/dev/null | awk '{print $1}' | string join +)

        set -a entries (jq -nc --arg sid $sid --arg folder $folder --arg project "$proj" --arg title "$title" \
            --arg remote "$remote" --arg branch "$branch" --arg toplevel "$toplevel" \
            --arg dirty $dirty --arg unpushed $unpushed \
            '{sid: $sid, folder: $folder, project: $project, title: $title,
              git: {remote: $remote, branch: $branch, toplevel: $toplevel, dirty: $dirty, unpushed: $unpushed}}')

        # Summary line, with anything that won't come along flagged.
        echo $bold(test -n "$title"; and echo $title; or echo $sid)$off $dim"($size)"$off
        echo "  "(string replace $HOME '~' -- $proj)(test -n "$branch"; and echo " @ $branch")
        string match -q -r '^(/private)?/tmp/' -- $proj; and echo $yellow"  ⚠ runs in a tmp scratchpad — that directory won't exist on the new machine"$off
        test "$dirty" != 0; and echo $yellow"  ⚠ $dirty uncommitted change(s) in $toplevel — commit/push or copy them separately"$off
        if test "$unpushed" = '?'
            echo $yellow"  ⚠ branch $branch has no upstream — push it if it holds work"$off
        else if test "$unpushed" != 0
            echo $yellow"  ⚠ $unpushed unpushed commit(s) on $branch"$off
        end
    end
    if test (count $entries) -eq 0
        rm -rf $stage
        return 1
    end

    printf '%s\n' $entries | jq -s --arg home $HOME --arg host (hostname -s) --arg at (date -u +%Y-%m-%dT%H:%M:%SZ) \
        '{home: $home, host: $host, exported_at: $at, sessions: .}' >$stage/manifest.json
    set -l sids (jq -r '.sessions[].sid' $stage/manifest.json)
    jq -c 'select(.sessionId as $s | $ARGS.positional | index($s))' $cfg/history.jsonl --args $sids >$stage/history.jsonl

    tar -czf $out -C $stage manifest.json history.jsonl -C $cfg (printf '%s\n' $files | sort -u)
    or begin
        rm -rf $stage
        return 1
    end
    rm -rf $stage
    echo
    echo "wrote "(count $sids)" session(s) to $bold$out$off ("(du -h $out | awk '{print $1}')")"
    echo $dim"on the new machine: claude-import "(path basename $out)$off
end
