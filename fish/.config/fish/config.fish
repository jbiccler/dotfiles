if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR nvim
set fish_greeting
starship init fish | source

alias ls="lsd"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git pull"
alias gP="git push"
