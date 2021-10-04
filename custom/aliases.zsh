# Navigation related
alias ..="cd ../"
alias ...="cd ../.."
alias c="clear"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias la="ls -la"

alias dot="cd ~/.dot-files"
alias 6="source ~/.zshrc; clear;"

# Git related
alias g="git"
alias gco="git checkout"
alias pull="git pull"

# Text editing
alias v="vim"

# Work related
alias j3="cd ~/stripe/stripe-js-v3/"
alias jb="cd ~/stripe-b/stripe-js-v3/"

# Second dev box
alias ps="cd ~/stripe/pay-server/"
alias pb="cd ~/stripe-b/pay-server/"

# Open this file without fuss
function edit_alias() {
  cd ~/.dot-files/custom
  vim aliases.zsh
  6
}

# Workflow related
alias p="work pr show"
alias b="work begin"

# Yarn stuff
alias y="yarn" 
alias fix="yarn run lint --fix && yarn run prettier"
