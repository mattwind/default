#!/usr/bin/env bash

echo "Starting Post Setup"

if [[ $EUID -ne 0 ]];
then
  echo "This script must be run as root" 
  exit 1
else
  apt-get update
  apt-get upgrade -y
  apt-get install visudo git vim -y
  usermod -a -G sudo mwind
fi
