#!/bin/bash

declare -a BREW_PACKAGES=(ripgrep fzf tmux)

for pkg in $BREW_PACKAGES; do
	echo $pkg
	brew install $pkg
done
