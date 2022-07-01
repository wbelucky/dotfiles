set fish_greeting ""


if status is-interactive
    set -gx TERM xterm-256color
    command -qv gh && eval (gh completion -s fish| source)
end

set -gx EDITOR nvim
set -gx GOPATH $HOME/go

set -q DOTFILES || set -gx DOTFILES $HOME/ghq/github.com/wbelucky/dotfiles-with-docker
set -gx AQUA_GLOBAL_CONFIG $DOTFILES/aqua.yaml

set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME $HOME/.local/share
set -q AQUA_ROOT_DIR || set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua

fish_add_path bin
fish_add_path ~/.bin
fish_add_path ~/.local/bin
fish_add_path $GOPATH/bin
fish_add_path node_modules/.bin

fish_add_path $AQUA_ROOT_DIR/bin

abbr -a 'clip' 'xclip -selection c'
abbr -a 'dc' 'docker-compose'
abbr -a 'dlmv' 'mv (ls -td $HOME/Downloads/* | head -n 1) .'
abbr -a 'g' 'git'
abbr -a 'gcd' 'ghq_change_directory'
abbr -a 'open' 'xdg-open'
abbr -a 'ga' 'git add'
abbr -a 'gap' 'git add -p'
abbr -a 'gcm' 'git commit -m "'
abbr -a 'gpl' 'git pull'
abbr -a 'gp' 'git push'
abbr -a 'gs' 'git status'
abbr -a 'gc' 'git checkout'
abbr -a 'gd' 'git diff'
abbr -a 'grs' 'git reset'
abbr -a 'gl' 'git log'
abbr -a 'gcl' 'ghq get'
abbr -a 'd' 'docker'
abbr -a 'dps' 'docker ps'
abbr -a 'di' 'docker images'
abbr -a ls 'exa --icons --git'

command -qv nvim && alias vim nvim

if command -qv exa
  alias ll 'exa -l --icons --git'
  alias lla 'll -a'
  alias lt 'exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias ltl 'exa -T -L 3 -a -I "node_modules|.git|.cache" -l --icons'
end

fish_vi_key_bindings

set PRIVATE_CONFIG (dirname (status --current-filename))/config-private.fish
if test -f $PRIVATE_CONFIG
  source $PRIVATE_CONFIG
end
