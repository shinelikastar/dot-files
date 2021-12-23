# Navigation related
alias ..="cd ../"
alias ...="cd ../.."
alias c="clear"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
abbrev-alias la="ls -la"

alias 6="source ~/.zshrc;"
alias 0="tmux source-file ~/.tmux.conf"

# Git related
alias g="git"
alias gco="git checkout"
alias pull="git pull"

# Text editing
alias vim="nvim"
alias v="nvim"

# Work related
alias j3="cd ~/stripe/stripe-js-v3/"
alias ps="cd ~/stripe/pay-server/"
alias dashboot='pay start admin admin_assets justification justification_assets manage manage_ui_metro excelsior api api_rpc k8s_manifests token-issuer-srv'

# Second dev box
abbrev-alias jb="cd ~/stripe-b/stripe-js-v3/"
abbrev-alias pb="cd ~/stripe-b/pay-server/"

# Edit this file without fuss
function edit_alias() {
  cd ~/.dot-files/custom
  vim aliases.zsh
  6
  cd -
}

alias dot="cd ~/.dot-files/"

# Workflow related
alias p="work pr show"
alias b="work begin"

# Yarn stuff
alias y="yarn" 
abbrev-alias fix="yarn run lint --fix && yarn run prettier"

