function __project_title --description 'Compute a project-aware title; fall back to path when not in a project'
    set -l root (__project_root)

    # Are we inside any git work tree? (repo or submodule)
    set -l in_git (command git rev-parse --is-inside-work-tree 2>/dev/null)

    # Helper: does the resolved root look like a "project" via common markers?
    set -l has_markers 0
    if test -e "$root/.project-root" \
        -o -e "$root/pyproject.toml" \
        -o -e "$root/package.json" \
        -o -e "$root/Cargo.toml" \
        -o -e "$root/go.mod" \
        -o -e "$root/Gemfile"
        set has_markers 1
    end

    if test "$in_git" = true -o $has_markers -eq 1
        # Optional per-project override
        if test -f "$root/.tabtitle"
            set -l t (string trim (cat "$root/.tabtitle"))
            if test -n "$t"
                printf '%s\n' -- "$t"
                return
            end
        end

        # Default: folder name of the project root
        printf '%s\n' -- (basename "$root")
        return
    end

    # Not a project: show the path with $HOME abbreviated to ~, no regexes, no list splitting
    set -l path -- "$PWD"
    if test -n "$HOME"
        set -l plen (string length -- "$HOME")
        if test (string sub -s 1 -l $plen -- "$path") = "$HOME"
            if test (string length -- "$path") -eq $plen
                set path "~"
            else if test (string sub -s (math $plen + 1) -l 1 -- "$path") = "/"
                # "~" + the remainder after $HOME
                set path "~"(string sub -s (math $plen + 1) -- "$path")
            end
        end
    end

    # Use printf to avoid list-to-string join surprises
    printf '%s\n' -- "$path"
end
