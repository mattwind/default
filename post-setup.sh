#!/usr/bin/env bash

echo "Starting Post Setup"

su -c 'apt-get update'
su -c 'apt-get install visudo git vim'
su -c 'usermod -a -G sudo mwind'

