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

function install_tpm() {
  if [ ! -d ~/.tmux/plugins/tpm ]; then
    dotsay "@yellow + installing tpm..."
    setenv -g TMUX_PLUGIN_MANAGER_PATH '$HOME/.tmux/plugins/'

    mkdir -p  ~/.tmux/plugins/tpm
    git clone git@github.com:tmux-plugins/tpm.git ~/.tmux/plugins/tpm

    # install any plugins already in tmux.conf
    local install_script="$HOME/.tmux/plugins/tpm/bin/install_plugins"

    if [ -x $install_script ]; then
      $install_script
    fi
  else
    dotsay "@green + tpm is already installed"
  fi
}


function brew_package_installed() {
  local package=$1

  brew list "$package" > /dev/null 2>&1
}

function install_iterm2() {
  if brew_package_installed iterm2 ; then
    dotsay "@green + iterm2 is already installed"
  else 
    dotsay "@yellow + installing iterm2..."
    brew cask install iterm2

    dotsay "@yellow + setting iterm2 as default shell..."
    sudo chsh -s $(which zsh) $USER
  fi
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

function install_ripgrep() {
  if brew_package_installed ripgrep ; then
    dotsay "@green + ripgrep is already installed"
  else
    dotsay "@magenta + installing ripgrep..."

    brew install ripgrep
  fi
}

function install_ack() {
  if brew_package_installed ack ; then
    dotsay "@green + ack is already installed"
  else
    dotsay "@magenta + installing ack..."

    brew install ack
  fi
}

function install_autojump() {
  if brew_package_installed autojump ; then
    dotsay "@green + autojump is already installed"
  else
    dotsay "@magenta + installing autojump..."

    brew install autojump
  fi
}

function install_ohmyzsh() {
  dotsay "@yellow + installing ohmyzsh..."

  git clone https://github.com/ohmyzsh/ohmyzsh ~/.oh-my-zsh
}

function install_zsh_autosuggestions() {
  dotsay "@yellow + installing zsh_autosuggestions..."

  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

function install_zsh_syntax_highlighting() {
  dotsay "@yellow + zsh_syntax_highlighting..."

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

function install_abbrev_alias() {
  dotsay "@yellow + abbrev_alias..."

  git clone https://github.com/momo-lab/zsh-abbrev-alias ~/.config/zsh-abbrev-alias/
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
ln -sf ~/.dot-files/iterm2/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist 

dotsay "@white setup git preferences"
ln -sf ~/.dot-files/git/gitconfig ~/.gitconfig

dotsay "@white setup neovim config"
ln -sf ~/.dot-files/nvim ~/.config/nvim

install_homebrew
install_ripgrep
install_ack
install_iterm2
install_autojump
install_base16_shell
select_base16_theme
install_fzf
install_nerd_font
install_ohmyzsh
install_abbrev_alias
install_zsh_autosuggestions
install_zsh_syntax_highlighting
install_tmux
install_tpm
brew install diff-so-fancy
