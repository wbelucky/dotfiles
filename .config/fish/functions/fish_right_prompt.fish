# @deprecated: powerline separator
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

function fish_right_prompt
    _prompt_user
    echo (set_color normal)(__fish_git_prompt "(%s)")
end
