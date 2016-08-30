# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

# set docker host
# set -x DOCKER_HOST localhost:2375

set -gx HOMEBREW_GITHUB_API_TOKEN ca8f6fde42417bc2104943e45ece8b8e20d2550a

# setup gopath
set -gx GOPATH ~/workspace/go
set -gx PATH $GOPATH/bin $PATH

# add brew sbin to path
set -gx PATH $PATH /usr/local/sbin

# set fzf default intput ag becuase ag respects ignored file settings
set -gx FZF_DEFAULT_COMMAND 'ag -g ""'

# import virtualfish: https://github.com/adambrenecki/virtualfish
eval (python -m virtualfish)
set -gx WORKON_HOME ~/environments
set -gx VIRTUALFISH_HOME ~/environments

# activate a virtualenv on entry
# also deactivates on project exit
# requires project root directory and virtualenv directory have the same name
# TODO: if no virtualfix is found try busting out of a venv
function chpwd --on-variable PWD --description "Activate Python virtualenvs on entry"
	set GIT_TOPLEVEL (git rev-parse --show-toplevel 2> /dev/null)

	# if we are in a git repo
	if test -n "$GIT_TOPLEVEL"
		set PROJECT (basename $GIT_TOPLEVEL)
		if test -d "$VIRTUALFISH_HOME/$PROJECT"
			vf activate $PROJECT
		end
	else
		if test -n "$VIRTUAL_ENV"
			vf deactivate
		end
	end
end
