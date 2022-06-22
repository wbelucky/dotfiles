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
abbr -a 'ga' 'git add'
abbr -a 'gap' 'git add -p'
abbr -a 'gcm' 'git commit -m "'
abbr -a 'gpl' 'git pull origin'
abbr -a 'gp' 'git push origin'
abbr -a 'gs' 'git status'
abbr -a 'gd' 'git diff'
abbr -a 'gcl' 'ghq get'
abbr -a 'd' 'docker'
abbr -a 'dps' 'docker ps'
abbr -a 'di' 'docker images'

command -qv nvim && alias vim nvim

fish_vi_key_bindings

set PRIVATE_CONFIG (dirname (status --current-filename))/config-private.fish
if test -f $PRIVATE_CONFIG
  source $PRIVATE_CONFIG
end
