#!/bin/env bash

user=mwind

if [[ $EUID -ne 0 ]];
then
  echo "Hello $USER"
  echo
  echo "Getting aliases"
  wget https://raw.githubusercontent.com/mattwind/default/master/.bash_aliases -O ~/
  echo "Getting some repos"
  mkdir ~/repos
  echo
  echo "Setting wallpaper"
  wget https://github.com/mattwind/default/raw/master/wallpaper.png -O ~/Pictures/wallpaper.png
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
  reset
  echo "Setting up screen"
  wget https://raw.githubusercontent.com/mattwind/default/master/.screenrc -O ~/.screenrc
  echo "Setting up Terminator"
  mkdir ~/.config
  mkdir ~/.config/terminator
  wget https://raw.githubusercontent.com/mattwind/default/master/.config/terminator/config -O ~/.config/terminator/config
  echo "Customizing dwm"
  sudo wget https://raw.githubusercontent.com/mattwind/default/master/dwm/config.h -O /opt/dwm/config.h
  cd /opt/dwm/
  sudo make
  sudo make install
  echo "Customizing dwmstatus"
  sudo wget https://raw.githubusercontent.com/mattwind/default/master/dwmstatus/dwmstatus.c -O /opt/dwmstatus/dwmstatus.c
  cd /opt/dwmstatus/
  sudo make
  sudo make install
  echo "Clean up"
  echo
  rm -rf ~/Public
  rm -rf ~/Templates
  echo "Setup google drive"
  opam init
  opam update
  opam install google-drive-ocamlfuse -y
  sudo ln -s /home/$user/.opam/system/bin/google-drive-ocamlfuse /usr/bin/google-drive-ocamlfuse
  sudo wget https://raw.githubusercontent.com/mattwind/default/master/scripts/gdfuse -O /usr/bin/gdfuse
  #. /home/$user/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
  #mount | grep /home/$user/Documents >/dev/null || google-drive-ocamlfuse /home/$user/Documents
  sync
  sudo system restart slim
else
  echo "This should not be run as root!" 
  exit 1
fi
