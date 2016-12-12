#!/usr/bin/env bash

function quit {
  echo
  echo "Finished now rebooting"
  reboot
  exit
}

function clean {
  apt-get purge nano -y
  apt-get autoremove -y
  apt-get autoclean
  apt-get clean
  mkdir /mnt/samsung/
}

function upgrade {
  wget https://raw.githubusercontent.com/mattwind/default/master/apt/jessie -O /etc/apt/sources.list
  apt-get update
  apt-get upgrade -y
  usermod -a -G sudo $user
}

function install {
  echo
  echo "Installing Software"
  echo "Take a break this could take a few minutes..."
  echo
  apt-get install `wget -q -O - https://raw.githubusercontent.com/mattwind/default/master/apt/packages.list` -y
  dwm
  google-drive
  apt-file update
}

function google-drive {
  groupadd fuse
  adduser $user fuse
  chown root.$user /dev/fuse
  chmod 660 /dev/fuse
}

function dwm {
  echo
  echo "Installing DWM"
  echo
  echo "Building dwm"
  cd /opt/
  git clone http://git.suckless.org/dwm
  cd dwm
  make
  make install
  echo "Building dmenu"
  cd /opt/
  git clone http://git.suckless.org/dmenu
  cd dmenu
  make
  make install
  echo "Building dwmstatus"
  cd /opt/
  git clone http://git.suckless.org/dwmstatus
  cd dwmstatus
  make
  make install
  echo "Done"
}

funciton getuser {
  echo
  echo -n "What is your username: "
  read username
  echo -n "You entered $username, is that correct? (y/n): "
  read reply

  if [ "$reply" != "y" ] then
    getuser
  else
    user="$username"
  fi
 }

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
  getuser
  upgrade $user
  install
  clean
  quit
fi

