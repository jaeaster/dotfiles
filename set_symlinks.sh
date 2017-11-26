#!/bin/bash

ln -s $HOME/dotfiles/zsh/.zshrc $HOME/.zshrc || true
ln -s $HOME/dotfiles/vim $HOME/.vim || true
ln -s $HOME/dotfiles/vim/.vimrc $HOME/.vimrc || true

ln -s $HOME/dotfiles/tmux/tmux.conf $HOME/.tmux.conf || true
