
# import virtualfish: https://github.com/adambrenecki/virtualfish
eval (python -m virtualfish)
set -g WORKON_HOME ~/environments
set -g VIRTUALFISH_HOME ~/environments

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

function resource
	source ~/.config/fish/config.fish
end
