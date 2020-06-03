alias g=git
alias 6="source $HOME/.zshrc"

# Load any private settings
[ -f ~/.zsh/private.zsh ] && source ~/.zsh/private.zsh

# Setup FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup base16 color schemes
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Set prompt
PROMPT="%~ %% "
