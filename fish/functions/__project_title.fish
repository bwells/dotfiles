function __project_title --description 'Project title or path'
    set -l root (__project_root)

    # inside any git work tree?
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1
    set -l in_git $status

    if test $in_git -eq 0
        # per-project override
        if test -f "$root/.tabtitle"
            set -l t (string trim (cat "$root/.tabtitle"))
            if test -n "$t"
                printf '%s\n' "$t"
                return
            end
        end

        # default: project folder name
        printf '%s\n' (basename "$root")
        return
    end

    # not in a project: show abbreviated path
    printf '%s\n' (prompt_pwd)
end
