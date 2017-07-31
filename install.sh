#!/bin/bash

DOT_FILES=(.emacs.d/init.el .emacs.d/Cask)

mkdir ~/.emacs.d
ln -s $HOME/dotsfiles/.emacs.d/init.el $HOME/.emacs.d/init.el
ln -s $HOME/dotsfiles/.emacs.d/Cask $HOME/.emacs.d/Cask
ln -s $HOME/dotsfiles/.tmux.conf $HOME/.tmux.conf
