#!/bin/env bash

if [[ $EUID -ne 0 ]];
then
  echo "Hello $USER"
  echo
  echo "Setting wallpaper"
  wget https://i.imgur.com/Bxdzgq4.png -O ~/Pictures/wallpaper.png
  sudo cp ~/Pictures/wallpaper.png /usr/share/slim/themes/debian-lines/background.png
  echo 
  echo "Setting default xsession"
else
  echo "This should not be run as root!" 
  exit 1
fi
