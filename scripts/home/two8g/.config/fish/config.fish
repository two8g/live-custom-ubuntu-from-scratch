alias i="sudo apt install"
alias lg="lazygit"
alias gst="git status"
alias t="tmuxinator start"
if status is-interactive
    # Commands to run in interactive sessions can go here
end
set fish_greeting
set -gx EDITOR vim
starship init fish | source
