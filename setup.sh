#!/bin/bash

# Install Xcode Command Line Tools
xcode-select --install

# Install symlinks
./install_symlinks.sh

# Install homebrew
./install_brew.sh

# Install homebrew packages
brew bundle

# Install fzf keybindings
$(brew --prefix)/opt/fzf/install

# Install asdf plugins
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
