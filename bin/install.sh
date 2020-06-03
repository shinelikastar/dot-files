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
  fi
}

echo "setup .zshrc config"
ln -sf ~/.dot-files/zshrc ~/.zshrc

echo "setup .zsh directory"
ln -sf ~/.dot-files/zsh ~/.zsh

install_fzf
