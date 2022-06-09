set fish_greeting ""


if status is-interactive

    set -gx TERM xterm-256color


    command -qv gh && eval (gh completion -s fish| source)
end

set -gx EDITOR nvim
set -gx PATH bin $PATH
set -gx PATH ~/.bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH
set -gx PATH node_modules/.bin $PATH

abbr -a 'clip' 'xclip -selection c'
abbr -a 'dc' 'docker-compose'
abbr -a 'dlmv' 'mv (ls -td $HOME/Downloads/* | head -n 1) .'
abbr -a 'g' 'git'
abbr -a 'gcd' 'cd (ghq list -p | fzf)'
abbr -a 'open' 'xdg-open'

command -qv nvim && alias vim nvim

