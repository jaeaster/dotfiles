#!/bin/bash

# Install Xcode Command Line Tools
xcode-select --install

# Speed up Keyrepeat settings
defaults write -g InitialKeyRepeat -int 12
defaults write -g KeyRepeat -int 1

# Install symlinks
./install_symlinks.sh

# Install homebrew
./install_brew.sh

# Install homebrew packages
brew bundle

# Install asdf plugins
echo 'legacy_version_file = yes' >> ~/.asdfrc
asdf plugin-add ruby
asdf plugin-add nodejs
asdf plugin-add python
