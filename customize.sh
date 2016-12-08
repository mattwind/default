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
  mkdir ~/.vim/colors/
  echo "Grabbing Vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  wget https://raw.githubusercontent.com/mattwind/default/master/.vimrc -O ~/.vimrc
  echo "Changing color"
  wget https://raw.githubusercontent.com/mattwind/default/master/.vim/colors/distinguished.vim -O ~/.vim/colors/distinguished.vim
  echo "Updating plugins"
  vim +PluginInstall +qall
  echo "Setting up screen"
  wget https://raw.githubusercontent.com/mattwind/default/master/.screenrc -O ~/.screenrc
  echo "Setting up Terminator"
  mkdir ~/.config/terminator/
  wget https://raw.githubusercontent.com/mattwind/default/master/.config/terminator/config -O ~/.config/terminator/config
  echo "Customizing dwm"
  cd /opt/dwm/
  sudo wget https://raw.githubusercontent.com/mattwind/default/master/dwm/config.h -O ./config.h
  sudo make
  sudo make install
else
  echo "This should not be run as root!" 
  exit 1
fi
