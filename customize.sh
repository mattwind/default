#!/bin/env bash
user=`whoami`

if [[ $EUID -ne 0 ]];
then
  echo "Hello $user"
  echo
  mkdir ~/repos
  cd ~/repos
  echo "Clone default project"
  git clone https://github.com/mattwind/default.git ~/repos/default
  echo 
  echo "Setting up dotfiles"
  cp -R ~/repos/default/dotfiles/* ~/
  echo
  echo "Clone vundle"
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  echo "Updating vim plugins"
  vim +PluginInstall +qall
  reset
  echo "Customizing dwm"
  sudo cp ~/repos/default/dwm/config.h /opt/dwm/config.h
  cd /opt/dwm/
  sudo make
  sudo make install
  echo "Customizing dwmstatus"
  sudo cp ~/repos/default/dwmstatus/dwmstatus.c /opt/dwmstatus/dwmstatus.c
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
  sudo mv ~/repos/default/scripts/gdfuse /usr/bin/gdfuse
  #. /home/$user/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
  #mount | grep /home/$user/Documents >/dev/null || google-drive-ocamlfuse /home/$user/Documents
  echo "Add Path"
  echo PATH=~/repos/default/scripts/:$PATH >> ~/.profile
  echo "Customizing Slim"
  sudo cp -R ~/repos/default/slim/* /usr/share/slim/themes/debian-lines/
  sync
  sudo /etc/init.d/slim restart
else
  echo "This should not be run as root!" 
  exit 1
fi
