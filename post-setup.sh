#!/usr/bin/env bash

function quit {
  exit
}

function clean {
  apt-get purge nano -y
  apt-get autoremove -y
  apt-get autolean
  apt-get clean
}

function upgrade {
  apt-get update
  apt-get upgrade -y
  apt-get install \
    sudo git vim apt-file \
    slim feh xorg xscreensaver xcompmgr gtk-chtheme \
    wireless-tools iw tcpdump wireshark ngrep nmap \
    irssi \
    build-essential libqt4-dev qt4-qtconfig libssl-dev -y
  apt-file update
  usermod -a -G sudo mwind
}

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
  upgrade
  clean
  quit
fi

