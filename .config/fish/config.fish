set fish_greeting ""

set -gx async_prompt_functions fish_right_prompt


# https://github.com/jorgebucaran/fisher/issues/640#issuecomment-1172984768
set fisher_path ~/.config/fish/fisher
! set --query fisher_path[1] || test "$fisher_path" = $__fish_config_dir && exit

set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..]
set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..]

for file in $fisher_path/conf.d/*.fish
    source $file
end


set -gx EDITOR nvim

set -gx GOPATH $HOME/go
fish_add_path $GOPATH/bin

# set -gx GOROOT $HOME/.go
# fish_add_path $GOROOT/bin

set -gx DENO_INSTALL $HOME/.deno
fish_add_path $DENO_INSTALL/bin

set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CONFIG_HOME $HOME/.config

set -gx AQUA_ROOT_DIR $XDG_DATA_HOME/aquaproj-aqua
fish_add_path $AQUA_ROOT_DIR/bin

set -gx AQUA_GLOBAL_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua.yaml
if uname -m | not grep -q arm
    set -gx AQUA_GLOBAL_CONFIG "$XDG_CONFIG_HOME/aquaproj-aqua/amd64.yaml:$AQUA_GLOBAL_CONFIG"
end

set -gx AQUA_POLICY_CONFIG $XDG_CONFIG_HOME/aquaproj-aqua/aqua-policy.yaml

# for gopls
set -gx AQUA_EXPERIMENTAL_X_SYS_EXEC true

fish_add_path $HOME/.cargo/bin
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

if set -q PRIVATE_CONFIGS
    source "$PRIVATE_CONFIGS/config-private.fish"
end
