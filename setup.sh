#!/bin/bash

ln -s ~/dot-config/.bash_profile ~/.bash_profile 
ln -s ~/dot-config/.vim ~/.vim
ln -s ~/dot-config/.vimrc ~/.vimrc
ln -s ~/dot-config/.tmux.conf ~/.tmux.conf
ln -s ~/dot-config/.gitconfig ~/.gitconfig
ln -s ~/dot-config/git-prompt.sh ~/git-prompt.sh

git submodule update --init .vim/bundle/nerdtree
git submodule update --init .vim/bundle/nerdcommenter
