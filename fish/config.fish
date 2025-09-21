# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

alias forget="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

alias vimr="vimr -s"

alias brewi="arch -x86_64 /usr/local/bin/brew"

alias ks="kubectl -n kube-system"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

alias k="kubectl"
alias ktx="kubectx"
alias kns="kubens"

# set -x HOMEBREW_NO_ENV_HINTS=1

if type -q nvim
    set -x EDITOR nvim
else
    alias vim nvim
    set -x EDITOR nvim
end

alias dbimport="~/workspace/ERP/erp/scripts/dbimport.py"

alias dbget="s5cmd --endpoint-url=https://s3-accelerate.amazonaws.com cp s3://alta-db-backups/(s5cmd ls s3://alta-db-backups | tail -n 1 | cut -w -f4) ~/Downloads"

alias inflate="/usr/local/bin/python3 -c 'import sys, zlib; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))'"

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

set -x KUBECONFIG /Users/kremlan/.kube/config:/Users/kremlan/.kube/k3s-aws-config:/Users/kremlan/.kube/k3s-office-config:/Users/kremlan/.kube/k3s-azure-config

set -x UV_PYTHON_PREFERENC only-managed

# Paths we want to add before system default paths
#set -l PREPEND_PATHS /opt/homebrew/bin /usr/local/Cellar/elm/0.19.1/bin /opt/homebrew/opt/python@3.10/bin /opt/homebrew/opt/python@3.9/bin /opt/homebrew/opt/python@3.11/bin
set -l PREPEND_PATHS /opt/homebrew/bin

for p in $PREPEND_PATHS
    if not contains $p $PATH
        set -x PATH $p $PATH
    end
end

# Paths we want to add after system default paths

# set -l APPEND_PATHS /opt/homebrew/opt/mysql@5.7/bin /Library/Frameworks/Python.framework/Versions/2.7/bin
#
# for p in $APPEND_PATHS
#     if not contains $p $PATH
#         set -x PATH $PATH $p
#     end
# end

set -x PATH $PATH ~/.local/bin

fish_add_path /opt/homebrew/opt/node@22/bin

# virtualfish/venv config
set -x VIRTUALFISH_HOME ~/environments

set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# import ssh keys on boot
ssh-add -A 2>/dev/null;

# completion for ccdecrypt
complete -c ccdecrypt -x -a " ( __fish_complete_suffix .cpt ) "

uvx --generate-shell-completion fish | source

# activate a virtualenv on entry
# also deactivates on project exit
#
# requires project root directory and virtualenv directory have the same name
function chpwd --on-variable PWD --description "Activate Python virtualenvs on entry"
    set GIT_TOPLEVEL (git rev-parse --show-toplevel 2> /dev/null)

    # if we are in a git repo
    if test -n "$GIT_TOPLEVEL"
        set PROJECT (basename $GIT_TOPLEVEL)

        # if a VENV is not active but does exist in the venvs home
        if test -z "$VIRTUAL_ENV" && test -d "$VIRTUALFISH_HOME/$PROJECT"
            # vf activate $PROJECT
            source $VIRTUALFISH_HOME/$PROJECT/bin/activate.fish

        # if a VENV is not active but does exist in a project local .venv directory
        else if test -z "$VIRTUAL_ENV" && [ -d .venv ]
            source .venv/bin/activate.fish

        # if a VENV is active but it is not the right one and the new one does exist
        else if [ "$VIRTUAL_ENV" != "$PROJECT" ] && test -d "$VIRTUALFISH_HOME/$PROJECT"
            # vf activate $PROJECT
            source $VIRTUALFISH_HOME/$PROJECT/bin/activate.fish

        # if a VENV is active but it is not the right one and the new one does exist in a project local .venv directory
        else if [ "$VIRTUAL_ENV" != "$PROJECT" ] && [ -d .venv ]
            source .venv/bin/activate.fish

        end
    else
        # if a deactivate function exists, use it
        if functions -q deactivate
            deactivate
        else if test -n "$VIRTUAL_ENV"
            vf deactivate
        end
    end
end

# activate a virtualenv on login
function check_and_activate_venv --on-event fish_prompt
    if status --is-interactive
        and status --is-login
        and not set -q VIRTUAL_ENV
        # Check if .venv exists in the current directory
        if test -d .venv
            source .venv/bin/activate.fish
        else
            set GIT_TOPLEVEL (git rev-parse --show-toplevel 2> /dev/null)
            if test -n "$GIT_TOPLEVEL"
                set PROJECT (basename $GIT_TOPLEVEL)
                if test -d "$VIRTUALFISH_HOME/$PROJECT"
                    source $VIRTUALFISH_HOME/$PROJECT/bin/activate.fish
                end
            end
        end
    end
end
