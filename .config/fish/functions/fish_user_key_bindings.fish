function fish_user_key_bindings
    fish_vi_key_bindings

    # accept fish gray suggestion with C-j
    # ref: https://github.com/fish-shell/fish-shell/issues/8619
    bind -M insert \cj accept-autosuggestion
    bind -M insert \cn down-or-search
    bind -M insert \cp up-or-search

end
