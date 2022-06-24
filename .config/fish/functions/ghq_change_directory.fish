function ghq_change_directory
  set -l dist (ghq list -p | fzf -q "$argv")
  if test -n "$dist"
    cd $dist
  end
end
