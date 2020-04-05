#!/bin/bash

declare -a BREW_PACKAGES=("autojump" "exa" "neovim" "reattach-to-user-namespace" "ripgrep" "source-highlight" "fzf" "tmux")
declare -a BREW_CASK_PACKAGES=("alacritty" "amethyst" "karabiner-elements")

brew update
brew upgrade

for pkg in "${BREW_PACKAGES[@]}"; do
	echo $pkg
	brew list $pkg || brew install $pkg
done

for pkg in "${BREW_CASK_PACKAGES[@]}"; do
	echo $pkg
	brew cask list $pkg || brew cask install $pkg
done

# install fzf keybindings
$(brew --prefix)/opt/fzf/install
