#!/usr/bin/env bash

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

echo "setup .zshrc config"
ln -sf ~/.dot-files/zshrc ~/.zshrc

echo "setup .zsh directory"
ln -sf ~/.dot-files/zsh ~/.zsh

echo "setup iterm2 preferences"
ln -sf ~/Library/Preferences/com.googlecode.iterm2.plist ../iterm2/com.googlecode.iterm2.plist



install_autojump
install_base16_shell
select_base16_themeinstall_fzf
