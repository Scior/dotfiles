#!/bin/sh
set -euo pipefail

cd ~
ln -sf dotfiles/.vimrc .vimrc
ln -sf dotfiles/.aliasrc .aliasrc
ln -sf dotfiles/.lldbinit .lldbinit
ln -sf dotfiles/.zshrc .zshrc
ln -sf dotfiles/.bashrc .bashrc
ln -sf dotfiles/.vim .vim

# HomeBrew
cd $(dirname $0)
if command -v brew >/dev/null; then
  echo "Skipped installing Homebrew."
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew doctor --verbose
  brew update --verbose
  brew bundle --file Brewfile --verbose
fi

# Vim
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
sh ./install.sh
rm ./install.sh
mkdir ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim

# VS Code
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait --merge "$LOCAL" "$REMOTE" "$BASE" "$MERGED"'
git config --global mergetool.prompt false
git config --global mergetool.keepBackup false

sudo chsh -s `which zsh` $USER
