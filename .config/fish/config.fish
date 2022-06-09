set fish_greeting ""


if status is-interactive

    set -gx TERM xterm-256color

    # Commands to run in interactive sessions can go here
    # Fish git prompt
    set __fish_git_prompt_showdirtystate 'yes'
    set __fish_git_prompt_showstashstate 'yes'
    set __fish_git_prompt_showuntrackedfiles 'yes'
    set __fish_git_prompt_showupstream 'yes'
    set __fish_git_prompt_color_branch yellow
    set __fish_git_prompt_color_upstream_ahead green
    set __fish_git_prompt_color_upstream_behind red

    # Status Chars
    set __fish_git_prompt_char_dirtystate '🚧'
    set __fish_git_prompt_char_stagedstate '🏁'
    set __fish_git_prompt_char_untrackedfiles '✨'
    set __fish_git_prompt_char_stashstate '📚'
    set __fish_git_prompt_char_upstream_ahead '⏩'
    set __fish_git_prompt_char_upstream_behind '⏪'

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

