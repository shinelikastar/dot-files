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

# Path to your oh-my-zsh installation.
export ZSH="/Users/starsu/.oh-my-zsh"

export PATH="/Users/starsu/.rbenv/shims:$PATH"
export PATH="/Users/starsu/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

# Enable git branch fzf search with "g co ** <TAB>"
_fzf_complete_git() {
    ARGS="$@"
    local branches
    branches=$(git branch -vv --all)
    if [[ $ARGS == 'g co'* ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

[[ ! -f ~/.dot-files/p10k.zsh ]] || source ~/.dot-files/p10k.zsh

# Import aliases
source ~/.dot-files/custom/aliases.zsh

# Setup FZF (this gotta stay at bottom idk why)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# enable vi-mode with 'jk'
bindkey -M viins 'jk' vi-cmd-mode

# bind zsh-autosuggestion to CMD-space
bindkey '^ ' autosuggest-accept

# p10k prompt
source ~/powerlevel10k/powerlevel10k.zsh-theme