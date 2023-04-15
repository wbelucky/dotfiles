function git_branch
  if test "$argv[1]" = "-a"
    git branch -a
  else
    set -l default_origin_br (git rev-parse --abbrev-ref origin/HEAD)
    set -l default_br (echo $default_origin_br | sed 's/origin\///')
    git branch -a --no-merged $default_origin_br | sed "1 i\ \ $default_br"
  end
end

# https://zenn.dev/yamo/articles/5c90852c9c64ab
function git_log_switch

  # set -l default_origin_br (git rev-parse --abbrev-ref origin/HEAD)
  # set -l default_br (echo $default_origin_br | sed 's/origin\///')

  set -l target_br (
      git_branch "$argv[1]" |
      fzf --exit-0 --layout=reverse --info=hidden --no-multi --preview-window="right,65%" --prompt="CHECKOUT BRANCH > " --preview="echo {} | tr -d ' *' | xargs git llog --color=always" |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if test -n "$target_br"
    git switch $target_br
  # zle accept-line
  end
end
