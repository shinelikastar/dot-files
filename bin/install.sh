#!/usr/bin/env bash

function install_homebrew() {
  which -s brew
  if [[ $? != 0 ]] ; then
  	echo "Installing homebrew"

  	ruby -e "$(curl -fsSL \
      		https://raw.githubusercontent.com/Homebrew/install/master/install)"
  else
  	brew update
  fi
}


function brew_package_installed() {
  local package=$1

  brew list "$package" > /dev/null 2>&1
}

function install_fzf() {
  if brew_package_installed fzf ; then
    echo "+ fzf is already installed"
  else
    echo "+ installing fzf..."

    brew install fzf
    $(brew --prefix)/opt/fzf/install
  fi
}

function install_autojump() {
  if brew_package_installed autojump ; then
    echo "+ autojump is already installed"
  else
    echo "+ installing autojump..."

    brew install autojump
  fi
}

function install_base16_shell() {
  if [ ! -d ~/.config/base16-shell ]; then
    mkdir -p ~/.config
    git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
  else
    echo "+ base16 already installed"
  fi
}

function select_base16_theme() {
  echo "+ selected base16 color theme"
  ln -sf ~/.config/base16-shell/scripts/base16-oceanicnext.sh ~/.base16_theme
}

function install_nerd_font() {
  FONT_FILE="/Library/Fonts/InconsolataGo Bold Nerd Font Complete Mono.ttf"
  # Use double brackets to escape spaces in $FONT_FILE name
  if [[ -f $FONT_FILE ]]; then
    echo "+ inconsolata go already installed"
  else 
    echo "+ installing inconsolata go"
    cd /Library/Fonts && curl -fLo "InconsolataGo Bold Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/InconsolataGo/Bold/complete/InconsolataGo%20Bold%20Nerd%20Font%20Complete%20Mono.ttf
  fi
}

echo "setup .zshrc config"
ln -sf ~/.dot-files/zshrc ~/.zshrc

echo "setup .zsh directory"
ln -sf ~/.dot-files/zsh ~/.zsh

echo "setup iterm2 preferences"
ln -sf ~/Library/Preferences/com.googlecode.iterm2.plist ~/.dot-files/iterm2/com.googlecode.iterm2.plist


install_homebrew
install_autojump
install_base16_shell
select_base16_theme
install_fzf
install_nerd_font