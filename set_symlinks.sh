#!/bin/bash

DOTFILES=$HOME/dotfiles

ln -sfn $DOTFILES/zsh/.zshrc $HOME/.zshrc || true

ln -sfn $DOTFILES/vim $HOME/.vim || true

ln -sfn $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf || true

ln -sfn $DOTFILES/config $HOME/.config || true

