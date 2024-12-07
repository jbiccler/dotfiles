if status is-interactive
    # Commands to run in interactive sessions can go here
end
set -gx EDITOR nvim
set fish_greeting

alias cd='z'
alias cl='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias l='eza -1  --icons'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias ts='~/.config/ml4w/scripts/snapshot.sh'
alias wifi='nmtui'
alias cleanup='~/.config/ml4w/scripts/cleanup.sh'

alias in='paru -S' # install package
alias un='paru -Rns' # uninstall package
alias up='paru -Syu' # update system/package/aur
alias pl='paru -Qs' # list installed package
alias pa='paru -Ss' # list availabe package
alias pc='paru -Sc' # remove unused cache
alias po='paru -Qtdq | paru pacman -Rns -' # remove unused packages, also try > pacman -Qqd | pacman -Rsu --print -
alias n='nvim' # code editor
alias ga="git add"
alias gs="git status"
alias gp="git pull"
alias gP="git push"
alias gc="git commit -m"

alias c23="g++ -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -pedantic-errors -ggdb -std=c++23"
alias c20="g++ -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -pedantic-errors -ggdb -std=c++20"
alias c="g++ -Wall -Weffc++ -Wextra -Wconversion -Wsign-conversion -Werror -pedantic-errors -ggdb"

alias cr="cargo run"
alias cb="cargo build"
alias ct="cargo test"

starship init fish | source
zoxide init fish | source
