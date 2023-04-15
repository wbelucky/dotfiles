# https://zenn.dev/yamo/articles/5c90852c9c64ab
function git_log_switch
  set -l target_br (
    git branch -a |
      fzf --exit-0 --layout=reverse --info=hidden --no-multi --preview-window="right,65%" --prompt="CHECKOUT BRANCH > " --preview="echo {} | tr -d ' *' | xargs git llog --color=always" |
      head -n 1 |
      perl -pe "s/\s//g; s/\*//g; s/remotes\/origin\///g"
  )
  if test -n "$target_br"
    git switch$target_br
  # zle accept-line
  end
end
