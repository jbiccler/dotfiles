

# -----------------------------------------------------
# INIT
# -----------------------------------------------------

source "$HOME/.zshrc_secrets"

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
export EDITOR=nvim
export PATH="/usr/lib/ccache/bin/:$PATH"
export PATH=$PATH:$HOME/.cargo/bin/
export ZSH="$HOME/.oh-my-zsh"

# -----------------------------------------------------
# oh-myzsh plugins
# -----------------------------------------------------
plugins=(
    git
    archlinux
    # zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    copyfile
    copybuffer
    # dirhistory
    rust
)

# Set-up oh-my-zsh
source $ZSH/oh-my-zsh.sh


# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
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
alias wifi='nmtui'
alias hx="helix"
alias cat="bat"

alias in='paru -S' # install package
alias un='paru -Rns' # uninstall package
alias up='paru -Syu' # update system/package/aur
alias pl='paru -Qs' # list installed package
alias pa='paru -Ss' # list availabe package
alias pc='paru -Sc' # remove unused cache
alias po='paru -Qtdq | paru pacman -Rns -' # remove unused packages, also try > pacman -Qqd | pacman -Rsu --print -
alias n='nvim'  # code editor
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

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export FZF_CTRL_R_OPTS="
  --color header:italic
  --height=80%
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'CTRL-Y: Copy command into clipboard, CTRL-/: Toggle line wrapping, CTRL-R: Toggle sorting by relevance'
  "

export FZF_CTRL_T_OPTS="
--walker-skip .git,node_modules,target
--preview 'bat -n --color=always {}'
--height=80%
--bind 'ctrl-/:change-preview-window(down|hidden|)'
--header 'CTRL-/: Toggle preview window position'
"

export FZF_ALT_C_OPTS="
--walker-skip .git,node_modules
--preview 'tree -C {}'
--height=80%
--bind 'ctrl-/:change-preview-window(down|hidden|)'
--header 'CTRL-/: Toggle preview window position'
"

