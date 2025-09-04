#!/bin/bash

ln -s ~/.dotfiles/_config/ipython ~/.ipython
mkdir -p ~/.config
mkdir -p ~/.ssh && ln -s ~/.dotfiles/_ssh/rc ~/.ssh/rc

cp ~/.dotfiles/_gitconfig ~/.gitconfig
ln -s ~/.dotfiles/_inputrc ~/.inputrc
ln -s ~/.dotfiles/_tmux.conf ~/.tmux.conf

mkdir -p ~/bin
ln -s ~/.dotfiles/bin/ak_git_clean_slate ~/bin/ak_git_clean_slate
