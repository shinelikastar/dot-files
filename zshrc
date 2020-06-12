alias 6="source $HOME/.zshrc"
alias ..="cd .."
alias ...="cd ../.."
alias c="clear"
alias l="ls -la"
alias gco="git checkout"
alias gp="git push"
alias v="nvim"
alias vim="nvim"

# Git-related
alias g="git"
alias pull="git pull"

# Work-related
alias j3="cd ~/stripe/stripe-js-v3/"

# Allow prompts to have dynamic variables
setopt PROMPT_SUBST

# Load any private settings
[ -f ~/.zsh/private.zsh ] && source ~/.zsh/private.zsh

# Load zinit plugin
[ -f ~/.zsh/zinit.zsh ] && source ~/.zsh/zinit.zsh

# Setup FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup base16 color schemes
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

function parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
# Set prompt
PROMPT="%~%F{green}\$(parse_git_branch)%f %% "

# setup autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export PATH="$PATH:$HOME/stripe/work/exe"
