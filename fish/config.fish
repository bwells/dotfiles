# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

# import virtualfish: https://github.com/adambrenecki/virtualfish
eval (python -m virtualfish)
set -gx WORKON_HOME ~/environments
set -gx VIRTUALFISH_HOME ~/environments

# activate a virtualenv on entry
# also deactivates on project exit
# requires project root directory and virtualenv directory have the same name
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
