#!/bin/bash

ln -s ~/dot-config/.bash_profile ~/.bash_profile 
ln -s ~/dot-config/.vim ~/.vim
ln -s ~/dot-config/.vimrc ~/.vimrc
ln -s ~/dot-config/.tmux.conf ~/.tmux.conf
ln -s ~/dot-config/.gitconfig ~/.gitconfig

git submodule update --init .vim/bundle/nerdtree
git submodule update --init .vim/bundle/nerdcommenter
git submodule update --init .vim/bundle/dbext.vim

curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o /etc/git-completion.bash
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o /etc/git-prompt.sh
