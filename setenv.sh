#!/bin/sh
cd ~
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.zshrc .zshrc
ln -sf dotfiles/.vim .vim

sudo chsh -s `which zsh` $USER
