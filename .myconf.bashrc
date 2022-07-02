# please load this in ~/.bashrc

# use vi key bindings
set -o vi
# not to stop with ctrl-s
stty stop undef

# if host is wsl
if [[ $(uname -r) =~ microsoft ]]; then
  export WINHOME=$(wslpath "$(wslvar USERPROFILE)")
  alias winmount='sudo mount -t ntfs-3g -o remove_hiberfile /dev/sda3 /mnt/win'
fi

# aliases
alias open='xdg-open'
alias vim='nvim'
alias clip='xclip -selection c'
alias gcd='cd $(ghq list -p | fzf)'

export EDITOR=vim
export GOPATH=$HOME/go
export TERM=xterm-256color
export XDG_CONFIG_HOME=$HOME/.config/

export DOTFILES="$HOME/ghq/github.com/wbelucky/dotfiles-with-docker"
export MYVIMRC=$HOME/.config/nvim/init.vim
export AQUA_GLOBAL_CONFIG="$DOTFILES/aqua.yaml"

export PATH=$PATH:$HOME/.local/bin/
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"
export PATH=$PATH:$HOME/.yarn/bin
export PATH=$PATH:$HOME/.config/yarn/global/node_modules/.bin
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin
export PATH="${AQUA_ROOT_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/aquaproj-aqua}/bin:$PATH"

# for fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# load private configs
if [ -f "$HOME/.private.bashrc" ]; then
    . "$HOME/.private.bashrc"
fi

# automatically start up tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

