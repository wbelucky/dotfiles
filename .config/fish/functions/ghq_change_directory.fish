function ghq_change_directory
  cd (ghq list -p | fzf -q "$argv")
end
