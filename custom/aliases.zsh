# Navigation related
alias ..="cd ../"
alias ...="cd ../.."
alias c="clear"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias l="ls -la"

alias dot="cd ~/.dot-files"
alias 6="source ~/.zshrc; clear;"

# Git related
alias g="git"
alias gco="git checkout"
alias gp="git push --force-with-lease"
alias pull="git pull"

# Text editing
alias v="nvim"
alias vim="nvim"

# Work related
alias j3="cd ~/stripe/stripe-js-v3/"
alias b="work begin"
