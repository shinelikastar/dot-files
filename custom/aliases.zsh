# Navigation related
alias ..="cd ../"
alias ...="cd ../.."
alias c="clear"

export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'
alias l="ls -la"

alias 6="exec zsh"
alias 0="tmux source-file ~/.tmux.conf"

alias tk="tmux kill-server"
alias tm="tmuxinator"

alias dot="cd ~/.dot-files/"

# Git related
alias g="git"

# Text editing
alias vim="nvim"
alias v="nvim"

# Work related
alias j3="cd ~/stripe/stripe-js-v3/"
alias ps="cd ~/stripe/pay-server/"
alias dashboot="pay start admin admin_metro justification justification_assets manage manage_ui_metro excelsior api api_rpc docs_manifests token-issuer-srv"

# Workflow related
alias p="work pr show"
alias b="work begin"
alias s="work pr switch"
alias r="work review"

# Yarn stuff
alias y="yarn" 

# Website stuff
WEBSITE="/Library/WebServer/Documents/shinelikastar.github.io"
alias w="cd $WEBSITE"

deploy () {
  cd $WEBSITE
  sudo npm --prefix star-site/ run deploy
  cd $OLDPWD
}

