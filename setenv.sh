#!/bin/sh

cd ~
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.aliasrc .aliasrc
ln -sf dotfiles/.lldbinit .lldbinit
ln -sf dotfiles/.zshrc .zshrc
ln -sf dotfiles/.bashrc .bashrc
ln -sf dotfiles/.vim .vim

# HomeBrew
cd $(dirname $0)
which brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
which brew >/dev/null 2>&1 && brew doctor --verbose
which brew >/dev/null 2>&1 && brew update --verbose
which brew >/dev/null 2>&1 && brew bundle --file Brewfile --verbose

# Vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm ./install.sh
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

sudo chsh -s `which zsh` $USER

