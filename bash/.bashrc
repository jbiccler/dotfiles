#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias pip='pip3'
export PATH="$HOME/.local/bin:$PATH"

PS1='[\u@\h \W]\$ '
