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

# Install fzf keybindings
$(brew --prefix)/opt/fzf/install

# Install Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install asdf plugins
echo 'legacy_version_file = yes' >> ~/.asdfrc
asdf plugin-add ruby
asdf plugin-add nodejs
asdf plugin-add python
