#!/bin/bash

# Install or update homebrew
which -s brew
if [[ $? != 0 ]] ; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

# Install `brew bundle` in order to use Brewfiles
brew tap Homebrew/bundle

# Install binaries and apps from Homebrew
brew bundle

