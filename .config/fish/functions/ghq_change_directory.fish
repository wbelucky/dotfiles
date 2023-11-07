function ghq_change_directory
  set -l dist (ghq list | fzf -q "$argv[1]")
  if test -n "$dist"
    cd "$GHQ_ROOT/$dist"
    return 0
  end
  return 1
end
