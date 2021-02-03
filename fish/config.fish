# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

alias forget="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

alias vimr="vimr -s"

if type -q nvim
    echo "no nvim"
    set -gx EDITOR vim
else
    echo "has nvim"
    alias vim nvim
    set -gx EDITOR nvim
end

alias dbimport="~/workspace/ERP/erp/scripts/dbimport.py"

alias inflate="/usr/local/bin/python3 -c 'import sys, zlib; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))'"

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

set -gx KUBECONFIG /Users/kremlan/.kube/config:/Users/kremlan/.kube/k3s-aws-config:/Users/kremlan/.kube/k3s-office-config

# setup gopath
# set -gx GOPATH ~/workspace/go
# set -gx PATH $GOPATH/bin $PATH

# set -gx PATH /usr/local/opt/openjdk@11/bin $PATH

#set -gx PATH /usr/local/opt/python@3.8/bin $PATH

# add brew sbin to path
#set -gx PATH $PATH /usr/local/sbin

#set -gx PATH $PATH /usr/local/opt/mysql@5.7/bin

#set -gx PATH $PATH /usr/local/opt/icu4c/bin /usr/local/opt/icu4c/sbin

#set -gx PATH $PATH ~/.cargo/bin

set -gx PATH /opt/homebrew/bin $PATH

# set fzf default intput ag becuase ag respects ignored file settings
# set -gx FZF_DEFAULT_COMMAND 'ag -g ""'
# export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"

# virtualfish/venv config
set -gx WORKON_HOME ~/environments
set -gx VIRTUALFISH_HOME ~/environments

# import ssh keys on boot
ssh-add -A 2>/dev/null;

# completion for ccdecrypt
complete -c ccdecrypt -x -a " ( __fish_complete_suffix .cpt ) "

# completion for pip-compile
# complete -c pip-compile -x -a " ( __fish_complete_suffix .in ) "

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
