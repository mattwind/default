#!/bin/env bash

if [[ $EUID -ne 0 ]];
then
  echo "Hello $USER"
  echo
  echo "Setting wallpaper"
  wget https://i.imgur.com/Bxdzgq4.png -O ~/Pictures/wallpaper.png
  echo "Customizing SLIM"
  sudo wget https://github.com/mattwind/default/raw/master/slim/background.png -O /usr/share/slim/themes/debian-lines/background.png
  sudo wget https://github.com/mattwind/default/raw/master/slim/panel.png -O /usr/share/slim/themes/debian-lines/panel.png
  sudo wget https://raw.githubusercontent.com/mattwind/default/master/slim/slim.theme -O /usr/share/slim/themes/debian-lines/slim.theme
  echo 
  echo "Setting default xsession"
  wget https://raw.githubusercontent.com/mattwind/default/master/.xsession -O ~/.xsession
  echo "Setting up vim"
  mkdir ~/.vim
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "This should not be run as root!" 
  exit 1
fi
