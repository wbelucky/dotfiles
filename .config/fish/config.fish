set fish_greeting ""

if status is-interactive
    set -gx TERM xterm-256color
    command -qv gh && eval (gh completion -s fish| source)
    source ~/.asdf/asdf.fish
end

set -gx EDITOR nvim
set -gx GOPATH $HOME/go

set -gx DENO_INSTALL $HOME/.deno
set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME $HOME/.local/share
set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME  $HOME/.config

set -q AQUA_ROOT_DIR || set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
set -q AQUA_GLOBAL_CONFIG || set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml

# for gopls
set -gx AQUA_EXPERIMENTAL_X_SYS_EXEC true

fish_add_path $AQUA_ROOT_DIR/bin
fish_add_path $GOPATH/bin
fish_add_path $DENO_INSTALL/bin
fish_add_path bin
fish_add_path node_modules/.bin
fish_add_path ~/.bin
fish_add_path ~/.local/bin

# DOTFILES, PRIVATE_CONFIGSなどを.wbconfigから読み込み
yq '.environment | to_entries | .[] | [.key, .value] | .[]' ~/.wbconfig |
while read -l var
  read -l val
  set -gx $var $val
end

abbr -a 'clip' 'xclip -selection c'
abbr -a 'd' 'docker'
abbr -a 'dc' 'docker-compose'
abbr -a 'di' 'docker images'
abbr -a 'dlmv' 'mv (ls -td $HOME/Downloads/* | head -n 1) .'
abbr -a 'dps' 'docker ps'
abbr -a 'g' 'git'
abbr -a 'ga' 'git add'
abbr -a 'gap' 'git add -p'
abbr -a 'gc' 'git commit'
abbr -a 'gcd' 'ghq_change_directory'
abbr -a 'gq' 'ghq_change_directory'
abbr -a 'gcl' 'ghq get'
abbr -a 'gd' 'git diff'
abbr -a 'gdc' 'git diff --cached'
abbr -a 'gl' 'git log'
# ref: https://zenn.dev/takuya/articles/7550d21ddd17f121602e#%E3%83%AA%E3%83%A2%E3%83%BC%E3%83%88%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%ABpush%E3%81%99%E3%82%8B
abbr -a 'gp' 'git push origin (git rev-parse --abbrev-ref HEAD)'
abbr -a 'gpl' 'git pull origin (git rev-parse --abbrev-ref HEAD)'
abbr -a 'grs' 'git reset'
abbr -a 'gs' 'git status'
abbr -a 'gw' 'git_log_switch'

if test -e /etc/os-release
  abbr -a 'open' 'xdg-open'
end

command -qv nvim && alias vim nvim
command -qv nvim && alias v nvim

if command -qv exa
  abbr -a ls 'exa --icons --git'
  abbr -a ll 'exa -l --icons --git'
  abbr -a lla 'll -a'
  abbr -a lt 'exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  abbr -a ltl 'exa -T -L 3 -a -I "node_modules|.git|.cache" -l --icons'
end

fish_vi_key_bindings

if set -q PRIVATE_CONFIGS
  source "$PRIVATE_CONFIGS/config-private.fish"
end

