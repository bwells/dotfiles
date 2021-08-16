source ~/.iterm2_shell_integration.(basename $SHELL)

# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

alias forget="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

alias vimr="vimr -s"

alias brewi="arch -x86_64 /usr/local/bin/brew"

alias ks="kubectl -n kube-system"

if type -q nvim
    set -gx EDITOR vim
else
    alias vim nvim
    set -gx EDITOR nvim
end

alias dbimport="~/workspace/ERP/erp/scripts/dbimport.py"

alias inflate="/usr/local/bin/python3 -c 'import sys, zlib; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))'"

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

set -gx KUBECONFIG /Users/kremlan/.kube/config:/Users/kremlan/.kube/k3s-aws-config:/Users/kremlan/.kube/k3s-office-config:/Users/kremlan/.kube/k3s-azure-config

# setup gopath
# set -gx GOPATH ~/workspace/go
# set -gx PATH $GOPATH/bin $PATH

# set -gx PATH /usr/local/opt/openjdk@11/bin $PATH

set -gx PATH /usr/local/Cellar/elm/0.19.1/bin $PATH

set -gx PATH /opt/homebrew/opt/python@3.8/bin $PATH

set -gx PATH /opt/homebrew/bin $PATH

set -gx PATH $PATH /opt/homebrew/opt/mysql@5.7/bin

# virtualfish/venv config
set -gx WORKON_HOME ~/environments
set -gx VIRTUALFISH_HOME ~/environments

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
