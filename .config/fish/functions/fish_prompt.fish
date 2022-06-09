function _prompt_user
    test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '

    test $USER = 'root'
    and echo (set_color red)"#"
end

function _prompt_dir

  # Git
  echo -n (set_color cyan)(prompt_pwd) (set_color normal)(__fish_vcs_prompt) 
end

function fish_prompt
    set -l last_status $status

    _prompt_user
    _prompt_dir

    if [ $last_status -gt 0 ]
      echo -n (set_color red)" [$last_status]"
    end

    echo -n (set_color normal)'❯ '
end

