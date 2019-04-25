#!/bin/bash

ln -s ~/.dotfiles/_config/ipython ~/.ipython
mkdir -p ~/.config
mkdir -p ~/.ssh
ln -s ~/.dotfiles/_ssh/rc ~/.ssh/rc

ln -s ~/.dotfiles/_ackrc ~/.ackrc
ln -s ~/.dotfiles/_gitconfig ~/.gitconfig
ln -s ~/.dotfiles/_inputrc ~/.inputrc
ln -s ~/.dotfiles/_tmux.conf ~/.tmux.conf
