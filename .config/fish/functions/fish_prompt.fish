function _prompt_dir
    echo -n (set_color cyan)

    set matched_part (string match -r "^$GHQ_ROOT/github.com/(.*)" $PWD)

    set matched_part $matched_part[2]

    if test -n "$matched_part"
        echo -n " /$(prompt_pwd "$matched_part")"
    else
        echo -n (prompt_pwd)
    end
end

function fish_prompt
    _prompt_dir
    echo -n " "
    set -l last_status $status
    if [ $last_status -gt 0 ]
      echo -n (set_color red)"[$last_status] "
    end
    echo -n (set_color green)" "
end
