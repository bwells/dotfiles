function __project_root --description 'Find project root; prefer Git superproject'
    # superproject if inside a submodule
    command git rev-parse --show-superproject-working-tree >/dev/null 2>&1
    if test $status -eq 0
        set -l super (command git rev-parse --show-superproject-working-tree 2>/dev/null)
        if test -n "$super"
            echo $super
            return
        end
    end

    # regular git toplevel
    command git rev-parse --show-toplevel >/dev/null 2>&1
    if test $status -eq 0
        set -l top (command git rev-parse --show-toplevel 2>/dev/null)
        if test -n "$top"
            echo $top
            return
        end
    end

    # fallback: current directory
    echo $PWD
end
