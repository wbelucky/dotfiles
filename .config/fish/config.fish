set fish_greeting ""


if status is-interactive

    set -gx TERM xterm-256color
    command -qv gh && eval (gh completion -s fish| source)
end

set -gx EDITOR nvim
set -gx GOPATH $HOME/go
fish_add_path bin
fish_add_path ~/.bin
fish_add_path ~/.local/bin
fish_add_path $GOPATH/bin
fish_add_path node_modules/.bin

abbr -a 'clip' 'xclip -selection c'
abbr -a 'dc' 'docker-compose'
abbr -a 'dlmv' 'mv (ls -td $HOME/Downloads/* | head -n 1) .'
abbr -a 'g' 'git'
abbr -a 'gcd' 'ghq_change_directory'
abbr -a 'open' 'xdg-open'

command -qv nvim && alias vim nvim

fish_vi_key_bindings
