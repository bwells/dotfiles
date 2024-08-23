# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

alias forget="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

alias vimr="vimr -s"

alias brewi="arch -x86_64 /usr/local/bin/brew"

alias ks="kubectl -n kube-system"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

# set -x HOMEBREW_NO_ENV_HINTS=1

if type -q nvim
    set -x EDITOR nvim
else
    alias vim nvim
    set -x EDITOR nvim
end

alias dbimport="~/workspace/ERP/erp/scripts/dbimport.py"

alias inflate="/usr/local/bin/python3 -c 'import sys, zlib; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))'"

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

set -x KUBECONFIG /Users/kremlan/.kube/config:/Users/kremlan/.kube/k3s-aws-config:/Users/kremlan/.kube/k3s-office-config:/Users/kremlan/.kube/k3s-azure-config

# Paths we want to add before system default paths
set -l PREPEND_PATHS /opt/homebrew/bin /usr/local/Cellar/elm/0.19.1/bin /opt/homebrew/opt/python@3.10/bin /opt/homebrew/opt/python@3.9/bin /opt/homebrew/opt/python@3.11/bin

for p in $PREPEND_PATHS
    if not contains $p $PATH
        set -x PATH $p $PATH
    end
end

# Paths we want to add after system default paths

set -l APPEND_PATHS /opt/homebrew/opt/mysql@5.7/bin /Library/Frameworks/Python.framework/Versions/2.7/bin

for p in $APPEND_PATHS
    if not contains $p $PATH
        set -x PATH $PATH $p
    end
end

set -x PATH $PATH ~/.local/bin

# virtualfish/venv config
set -x WORKON_HOME ~/environments
set -x VIRTUALFISH_HOME ~/environments

set -x VIRTUAL_ENV_DISABLE_PROMPT 1

# import ssh keys on boot
ssh-add -A 2>/dev/null;

# completion for ccdecrypt
complete -c ccdecrypt -x -a " ( __fish_complete_suffix .cpt ) "

# activate a virtualenv on entry
# also deactivates on project exit
#
# requires project root directory and virtualenv directory have the same name
function chpwd --on-variable PWD --description "Activate Python virtualenvs on entry"
    set GIT_TOPLEVEL (git rev-parse --show-toplevel 2> /dev/null)

    # if we are in a git repo
    if test -n "$GIT_TOPLEVEL"
        set PROJECT (basename $GIT_TOPLEVEL)

        # if a VENV is not active but does exist
        if test -z "$VIRTUAL_ENV" && test -d "$VIRTUALFISH_HOME/$PROJECT"
            vf activate $PROJECT
        # if a VENV is active but it is not the right one and the new one does exist
        else if [ "$VIRTUAL_ENV" != "$PROJECT" ] && test -d "$VIRTUALFISH_HOME/$PROJECT"
            vf activate $PROJECT
        end
    else
        if test -n "$VIRTUAL_ENV"
            vf deactivate
        end
    end
end
