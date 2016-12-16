#!/usr/bin/env bash
user=$1

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
  echo "Adding $user to sudoers"
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
  echo "Adding $user to fuse group"
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
  mkdir dwm-6.0
  wget https://github.com/mattwind/default/raw/master/dwm/dwm-6.0.tar.gz
  tar xvf dwm-6.0.tar.gz 
  mv dwm-6.0 dwm
  cd dwm
  wget https://raw.github.com/mattwind/default/master/dwm/dwm-systray-6.0.diff
  patch < dwm-systray-6.0.diff  
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

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
#  read -p "$user are you sure? " -n 1 -r
#  echo    # (optional) move to a new line
#  if [[ $REPLY =~ ^[Yy]$ ]]
#  then
    upgrade
    install
    clean
    quit
#  fi
fi

