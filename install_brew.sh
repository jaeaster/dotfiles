#!/bin/bash

# Install or update homebrew
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Install `brew bundle` in order to use Brewfiles
brew tap Homebrew/bundle

# Install binaries and apps from Homebrew
brew bundle

