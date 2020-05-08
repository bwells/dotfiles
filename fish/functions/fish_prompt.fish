# Options
# set __fish_git_prompt_show_informative_status
set __fish_git_prompt_showcolorhints
set __fish_git_prompt_showdirtystate
set __fish_git_prompt_showstashstate
set __fish_git_prompt_showupstream "auto"

# Colors
set normal (set_color normal)
set green (set_color green)
set magenta (set_color magenta)
set red (set_color red)
set yellow (set_color yellow)
set cyan (set_color cyan)
set blue (set_color blue)

set __fish_git_prompt_color_branch red --bold
set __fish_git_prompt_color_merging yellow

set __fish_git_prompt_char_stateseparator '|'

set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_char_cleanstate '✔'

# set __fish_git_prompt_char_untrackedfiles '🔍'
#
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_char_upstream_ahead '☝️ '

set __fish_git_prompt_color_upstream_behind red
set __fish_git_prompt_char_upstream_behind '👇'
set __fish_git_prompt_char_upstream_diverged '🚧'
set __fish_git_prompt_char_upstream_equal '💯'

# set __fish_git_prompt_char_conflictedstate '✖'
set __fish_git_prompt_char_conflictedstate '🖕'

set __fish_git_prompt_color_dirtystate green
# set __fish_git_prompt_char_dirtystate '✚'
set __fish_git_prompt_char_dirtystate '✍️ '

set __fish_git_prompt_color_invalidstate red
# set __fish_git_prompt_char_invalidstate '✖'
set __fish_git_prompt_char_invalidstate '👎'

set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_char_stagedstate '●'

set __fish_git_prompt_char_stashstate '📦'

# 🤘 🖕 👌 🖖

set fish_color_cwd cyan

function fish_prompt
  set last_status $status

  set_color $fish_color_cwd
  printf '%s' (basename (prompt_pwd))
  set_color normal

  printf '%s ' (__fish_git_prompt)
end
