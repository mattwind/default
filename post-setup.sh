#!/usr/bin/env bash
user=mwind

function quit {
  exit
}

function clean {
  apt-get purge nano -y
  apt-get autoremove -y
  apt-get autolean
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
  apt-get install \
    sudo git vim apt-file terminator htop screen gnome-screenshot caja software-properties-common \
    slim feh xorg xscreensaver xcompmgr gtk-chtheme trayer \
    wireless-tools iw tcpdump wireshark ngrep nmap network-manager-gnome ssh \
    monodevelop mono-complete virtualbox \
    vlc pavucontrol mate-power-manager mate-media-pulse jmtpfs \
    chromium irssi libreoffice gimp \
    m4 libcurl4-gnutls-dev libfuse-dev libsqlite3-dev opam ocaml make fuse camlp4-extra pkg-config zlib1g zlib1g-dev \
    build-essential libqt4-dev qt4-qtconfig libssl-dev -y
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
  cd /opt/
  git clone http://git.suckless.org/dwm
  cd dwm
  apt-get install libxft-dev libxinerama-dev
  make
  make install
  cd /opt/
  git clone http://git.suckless.org/dmenu
  cd dmenu
  make
  make install
  cd /opt/
  git clone http://git.suckless.org/dwmstatus
  make
  make install
}

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
  upgrade
  install
  clean
  quit
fi

