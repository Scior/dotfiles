#!/usr/bin/env/ sh
cd ~
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.aliasrc .aliasrc
ln -sf dotfiles/.lldbinit .lldbinit
ln -sf dotfiles/.zshrc .zshrc
ln -sf dotfiles/.bashrc .bashrc
ln -sf dotfiles/.vim .vim

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm ./install.sh
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

sudo chsh -s `which zsh` $USER

