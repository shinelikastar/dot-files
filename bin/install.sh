#!/usr/bin/env bash
source ~/.dot-files/bin/stdout.sh

dotheader "Installing shit... "

function install_homebrew() {
  which -s brew
  if [[ $? != 0 ]] ; then
        dotsay "@green + installing homebrew"

  	ruby -e "$(curl -fsSL \
      		https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
	dotsay "@magenta + updating homebrew"
  	brew update
  fi
}


function brew_package_installed() {
  local package=$1

  brew list "$package" > /dev/null 2>&1
}

function install_fzf() {
  if brew_package_installed fzf ; then
    dotsay "@green + fzf is already installed"
  else
    dotsay "@yellow + installing fzf..."

    brew install fzf
    $(brew --prefix)/opt/fzf/install
  fi
}

function install_autojump() {
  if brew_package_installed autojump ; then
    dotsay "@green + autojump is already installed"
  else
    dotsay "@yellow + installing autojump..."

    brew install autojump
  fi
}

function install_base16_shell() {
  if [ ! -d ~/.config/base16-shell ]; then
    mkdir -p ~/.config
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  else
    dotsay "@green + base16 already installed"
  fi
}

function select_base16_theme() {
  dotsay "@magenta + selected base16 color theme"
  ln -sf ~/.config/base16-shell/scripts/base16-oceanicnext.sh ~/.base16_theme
}

function install_nerd_font() {
  FONT_FILE="/Library/Fonts/InconsolataGo Bold Nerd Font Complete Mono.ttf"
  # Use double brackets to escape spaces in $FONT_FILE name
  if [[ -f $FONT_FILE ]]; then
    dotsay "@green + inconsolata go already installed"
  else 
    dotsay "@yellow + installing inconsolata go..."
    cd /Library/Fonts && curl -fLo "InconsolataGo Bold Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/InconsolataGo/Bold/complete/InconsolataGo%20Bold%20Nerd%20Font%20Complete%20Mono.ttf
  fi
}

function install_antigen() {
  if [ ! -f ~/antigen.zsh ]; then
    dotsay "@yellow + installing antigen..."
    curl -L git.io/antigen > antigen.zsh
    
    source ~/.zshrc
    antigen bundle zsh-users/zsh-completions
    antigen bundle zdharma/fast-syntax-highlighting
  else
    dotsay "@green + antigen already installed"
  fi
}

function install_tmux() {
  if brew_package_installed tmux; then
    dotsay "@green + tmux already installed"
  else
    dotsay "@yellow + installing tmux..."
    sudo apt install tmux	
  fi
}

dotsay "@white setup .zshrc config"
ln -sf ~/.dot-files/zshrc ~/.zshrc

dotsay "@white setup .zsh directory"
ln -sf ~/.dot-files/zsh ~/.zsh

dotsay "@white setup iterm2 preferences"
ln -sf ~/Library/Preferences/com.googlecode.iterm2.plist ~/.dot-files/iterm2/com.googlecode.iterm2.plist

dotsay "@white setup git preferences"
ln -sf ~/.dot-files/git/gitconfig ~/.gitconfig


install_homebrew
install_autojump
install_base16_shell
select_base16_theme
install_fzf
install_nerd_font
install_antigen
install_tmux
brew install diff-so-fancy
