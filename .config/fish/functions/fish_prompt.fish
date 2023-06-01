function fish_prompt
    set -l last_status $status
    if [ $last_status -gt 0 ]
      echo -n (set_color red)"[$last_status] "
    end
    echo -n (set_color green)" "
end
