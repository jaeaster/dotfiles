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
echo 'legacy_version_file = yes' >> ~/.asdfrc
asdf plugin-add ruby
asdf plugin-add nodejs
asdf plugin-add python
