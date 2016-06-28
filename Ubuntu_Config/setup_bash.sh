#!/bin/bash
CUR_DIR=`pwd`
CUR_DIR_BASE=`basename $CUR_DIR`
if [ $CUR_DIR_BASE != "Ubuntu_Config" ]; then
  echo "You must be in the same directory as the script to run it."
  exit
fi

if [ -f ~/.bashrc ]; then
  rm ~/.bashrc
elif [ -h ~/.bashrc ]; then
  unlink ~/.bashrc
fi
ln -s $CUR_DIR/.bashrc ~/.bashrc

if [ -f ~/.vimrc ]; then
  rm ~/.vimrc
elif [ -h ~/.vimrc ]; then
  unlink ~/.vimrc
fi
ln -s $CUR_DIR/.vimrc ~/.vimrc

if [ -f ~/.bash_functions ]; then
  rm ~/.bash_functions
elif [ -h ~/.bash_functions ]; then
  unlink ~/.bash_functions
fi
ln -s $CUR_DIR/.bash_functions ~/.bash_functions

if [ -f ~/.bash_aliases ]; then
  rm ~/.bash_aliases
elif [ -h ~/.bash_aliases ]; then
  unlink ~/.bash_aliases
fi
ln -s $CUR_DIR/.bash_aliases ~/.bash_aliases

if [ -f ~/.git-completion.bash ]; then
  rm ~/.git-completion.bash
elif [ -h ~/.git-completion.bash ]; then
  unlink ~/.git-completion.bash
fi
ln -s $CUR_DIR/git-completion.bash ~/.git-completion.bash

if [ -f ~/.git-prompt.sh ]; then
  rm ~/.git-prompt.sh
elif [ -h ~/.git-prompt.sh ]; then
  unlink ~/.git-prompt.sh
fi
ln -s $CUR_DIR/git-prompt.sh ~/.git-prompt.sh
