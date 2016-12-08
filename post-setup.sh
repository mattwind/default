#!/usr/bin/env bash

echo "Starting Post Setup"

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
  apt-get clean
}

function upgrade {
  apt-get update
  apt-get upgrade -y
  apt-get install visudo git vim -y
  usermod -a -G sudo mwind
}
