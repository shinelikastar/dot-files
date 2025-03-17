# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

eval $(/opt/homebrew/bin/brew shellenv) 

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

# Path to your oh-my-zsh installation.
export ZSH="/Users/starsu/.oh-my-zsh"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$(go env GOPATH)/bin:$PATH

### BEGIN SPACE COMMANDER
export PATH="/Users/starsu/stripe/space-commander/bin:$PATH"
### END SPACE COMMANDER

### BEGIN APIORI GO
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
### END APIORI GO

# Cargo
export PATH="/Users/starsu/.cargo/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/starsu/.oh-my-zsh"

export PATH="/Users/starsu/.rbenv/shims:$PATH"
export PATH="/Users/starsu/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
eval "$(nodenv init -)"

# History settings
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

plugins=(
	autojump
	git 
	sudo
	vi-mode
	zsh-autosuggestions
	zsh-syntax-highlighting 
)

source $ZSH/oh-my-zsh.sh

# User configuration
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1
export PATH="$PATH:$HOME/stripe/work/exe"

[[ ! -f ~/.dot-files/p10k.zsh ]] || source ~/.dot-files/p10k.zsh
[ -f ~/.base16_theme ] && source ~/.base16_theme

# Import aliases
source ~/.dot-files/custom/aliases.zsh

# Setup FZF (this gotta stay at bottom idk why)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable vi-mode with 'jk'
bindkey -M viins 'jk' vi-cmd-mode

# bind zsh-autosuggestion to CMD-space
bindkey '^ ' autosuggest-accept
bindkey '\C-i' autosuggest-execute

# p10k prompt
source ~/powerlevel10k/powerlevel10k.zsh-theme
alias luamake=/Users/starsu/stripe/lua-language-server/3rd/luamake/luamake

# source Stripe stuff
source ~/.stripe/shellinit/bash_profile

# START - Managed by chef cookbook stripe_cpe_bin
# alias tc='/usr/local/stripe/bin/test_cookbook'
# alias cz='/usr/local/stripe/bin/chef-zero'
# alias cookit='tc && cz'
# STOP - Managed by chef cookbook stripe_cpe_bin
