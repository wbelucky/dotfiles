echo "Loading .config/fish/config.fish ..."
set fish_greeting ""

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


if set -q PRIVATE_CONFIGS
  source "$PRIVATE_CONFIGS/config-private.fish"
end

# for ssh-agent ref: https://zenn.dev/kaityo256/articles/ssh_agent_on_wsl
if command -qv keychain
  keychain -q --nogui $HOME/.ssh/id_ed25519
  source $HOME/.keychain/$hostname-fish
end

if status is-interactive
    source $HOME/.config/fish/abbr.fish

    set -gx TERM xterm-256color
    # ghにはデフォルトで保管の設定がなされている? https://github.com/fish-shell/fish-shell/blob/master/share/completions/gh.fish
    # echo "Loading gh completion $(date "+%S%N")"
    # command -qv gh && eval (gh completion -s fish | source)
    # echo "Finish loading gh completion $(date "+%S%N")"
    source ~/.asdf/asdf.fish
end

echo "Finish loading .config/fish/config.fish"
