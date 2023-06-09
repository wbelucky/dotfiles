
# Commands to run in interactive sessions can go here
# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '🚧'
set __fish_git_prompt_char_stagedstate '🏁'
set __fish_git_prompt_char_untrackedfiles '✨'
set __fish_git_prompt_char_stashstate '📚'
set __fish_git_prompt_char_upstream_ahead '⏩'
set __fish_git_prompt_char_upstream_behind '⏪'


function _segment
  set_color -b $argv[1] $argv[2]
  echo -n \ue0b0
end


function _prompt_user
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '

    test $USER = 'root'
    and echo (set_color red)"#"
end

function _prompt_dir
  # Git
  echo -n (set_color cyan)(prompt_pwd) (set_color normal)(__fish_git_prompt "(%s)")
end

function fish_right_prompt
    _prompt_user
    _prompt_dir
end
