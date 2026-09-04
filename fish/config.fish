# create an alias to edit fish config
abbr -a fe vim ~/.config/fish/config.fish
abbr -a resource source ~/.config/fish/config.fish

alias forget="sudo killall -HUP mDNSResponder; sudo killall mDNSResponderHelper; sudo dscacheutil -flushcache"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

alias k="kubectl"
alias ktx="kubectx"
alias kns="kubens"

alias p="pulumi"

# set -x HOMEBREW_NO_ENV_HINTS=1

if type -q nvim
    alias vim nvim
    set -x EDITOR nvim
else
    set -x EDITOR nvim
end

alias dbimport="~/workspace/ERP/erp/scripts/dbimport.py"

alias dbget="s5cmd --endpoint-url=https://s3-accelerate.amazonaws.com cp s3://alta-db-backups/(s5cmd ls s3://alta-db-backups | tail -n 1 | cut -w -f4) ~/Downloads"

alias inflate="/usr/local/bin/python3 -c 'import sys, zlib; sys.stdout.buffer.write(zlib.decompress(sys.stdin.buffer.read()))'"

# add workspace to cd search path
set -U CDPATH . ~ ~/workspace

set -x KUBECONFIG /Users/kremlan/.kube/config:/Users/kremlan/.kube/k3s-azure-config

set -x UV_PYTHON_PREFERENC only-managed

# disable showing active venv in prompt
set -x VIRTUAL_ENV_DISABLE_PROMPT 1

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

# fish_add_path /opt/homebrew/opt/node@22/bin

# import ssh keys on boot
ssh-add -A 2>/dev/null;

# completion for ccdecrypt
complete -c ccdecrypt -x -a " ( __fish_complete_suffix .cpt ) "

uvx --generate-shell-completion fish | source

# Secrets (API keys and tokens) live in ~/.config/fish/conf.d/secrets.fish,
# which is gitignored and auto-sourced by fish. On a new machine, recreate
# it with `set -x NAME value` lines for:
#   OPENAI_API_KEY
#   ANTHROPIC_API_KEY
#   GEMINI_API_KEY
#   HF_TOKEN
#   GITHUB_PERSONAL_ACCESS_TOKEN
#   RUNPOD_API_KEY
#   ELEVENLABS_API_KEY
#   LOGGLY_TOKEN
#   ZENDESK_API_TOKEN

set -x LOGGLY_SUBDOMAIN alta
set -x ZENDESK_SUBDOMAIN altalang
set -x ZENDESK_EMAIL bwells@altalang.com

# PR Review Chat group chat - for teams-cli
set -x TEAMS_CHAT_ID 19:02449f32b5f24aa1962249d425897c7d@thread.v2

set -x PR_ASSET_BUCKET alta-pr-assets
set -x PR_ASSET_PUBLIC_BASE_URL https://pr-assets.ops.altalang.com

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -x KOPS_STATE_STORE s3://alta-kubernetes-state-store

set -Ux AWS_PROFILE prod

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

function latest_tag --description "Print the latest semver tag for the current repo, or nothing if none exists"
    git tag --list --sort=-v:refname | string match -r '^v?[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1
end

function next_tag --description "Print the next semver tag for the current repo (default bump: patch)"
    set -l bump $argv[1]
    if test -z "$bump"
        set bump patch
    end

    set -l latest (latest_tag)

    set -l prefix ""
    set -l ver 0.0.0
    if test -n "$latest"
        if string match -q 'v*' -- $latest
            set prefix v
            set ver (string sub -s 2 -- $latest)
        else
            set ver $latest
        end
    end

    set -l parts (string split . -- $ver)
    set -l major $parts[1]
    set -l minor $parts[2]
    set -l patch $parts[3]

    switch $bump
        case major
            set major (math $major + 1)
            set minor 0
            set patch 0
        case minor
            set minor (math $minor + 1)
            set patch 0
        case patch ''
            set patch (math $patch + 1)
        case '*'
            echo "next_tag: unknown bump '$bump' (expected major/minor/patch)" >&2
            return 1
    end

    echo "$prefix$major.$minor.$patch"
end

function predeploy --description "PR-merge cleanup: switch to main/master, pull, prune remotes, delete local branches with gone upstream"
    git rev-parse --git-dir >/dev/null 2>&1; or begin
        echo "predeploy: not in a git repo" >&2
        return 1
    end

    set -l main_branch
    if git show-ref --verify --quiet refs/heads/main
        set main_branch main
    else if git show-ref --verify --quiet refs/heads/master
        set main_branch master
    else
        echo "predeploy: no main or master branch found" >&2
        return 1
    end

    set -l current (git symbolic-ref --short HEAD 2>/dev/null)
    if test "$current" != "$main_branch"
        echo "→ git checkout $main_branch"
        git checkout $main_branch; or return 1
    end

    echo "→ git pull -p"
    git pull -p; or return 1

    set -l gone (git branch -vv | awk '/: gone\]/ {sub(/^\* /, ""); print $1}')
    if test (count $gone) -eq 0
        echo "✓ no local branches with pruned upstreams"
        return 0
    end

    echo "→ deleting local branches with pruned upstreams:"
    for b in $gone
        echo "  - $b"
    end
    for b in $gone
        git branch -D $b; or return 1
    end
end

function deploy --description "Tag, push, and run 'inv deploy'. Uses arg as tag, otherwise next_tag."
    set -l tag $argv[1]
    if test -z "$tag"
        set -l prev (latest_tag)
        if test -n "$prev"
            echo "→ previous tag: $prev"
        else
            echo "→ previous tag: (none found)"
        end
        set tag (next_tag); or return 1
        echo "→ next tag:     $tag"
    end

    echo "→ git tag $tag"
    git tag $tag; or return 1

    echo "→ git push origin $tag"
    git push origin $tag; or return 1

    echo "→ inv deploy $tag"
    inv deploy $tag
end

# opencode
fish_add_path /Users/kremlan/.opencode/bin
