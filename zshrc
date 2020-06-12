# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Setup Powerlevel 10K
zinit ice depth=1; zinit light romkatv/powerlevel10k

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
