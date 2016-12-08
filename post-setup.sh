#!/usr/bin/env bash

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
  upgrade  
  clean
  quit
fi

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
  apt-get install visudo git vim -y
  usermod -a -G sudo mwind
}
