function __project_root --description 'Find project root; prefer Git superproject when in a submodule'
    set -l root ""

    # If inside a git submodule, this returns the superproject working tree.
    set -l super (command git rev-parse --show-superproject-working-tree 2>/dev/null)
    if test -n "$super"
        set root "$super"
    else
        # Toplevel if in a regular git repo.
        set -l top (command git rev-parse --show-toplevel 2>/dev/null)
        if test -n "$top"
            set root "$top"
        else
            # Fallback: walk up for common project markers.
            set -l dir "$PWD"
            while test "$dir" != "/"
                if test -e "$dir/.project-root" \
                    -o -e "$dir/.git" \
                    -o -e "$dir/pyproject.toml" \
                    -o -e "$dir/package.json" \
                    -o -e "$dir/Cargo.toml" \
                    -o -e "$dir/go.mod" \
                    -o -e "$dir/Gemfile"
                    set root "$dir"
                    break
                end
                set dir (dirname "$dir")
            end

            # If nothing matched, use current dir.
            if test -z "$root"
                set root "$PWD"
            end
        end
    end

    echo $root
end
