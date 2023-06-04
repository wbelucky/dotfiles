# please load this in ~/.bashrc
export WB_MYCONF_LOADED=1

# automatically start up tmux
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -2u new-session -A -s fish
fi
