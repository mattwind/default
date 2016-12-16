#!/usr/bin/env bash
user=$1

if [ "$user" == "" ];
then
	echo "No user specified"
	echo "./post.sh mwind"
	exit 1
fi

apt-get install git -y
cd /tmp
git clone https://github.com/mattwind/default.git
cd default

cp /tmp/apt/jessie /ect/apt/source.list
apt-get update
apt-get upgrade -y

usermod -a -G sudo $user
apt-get install `cat apt/packages.list` -y

groupadd fuse
adduser $user fuse
chown root.$user /dev/fuse
chmod 660 /dev/fuse

tar -xf /tmp/default/dwm/dwm-6.0.tar.gz -C /opt/dwm/
cp /tmp/dwm/dwm-systray-6.0.diff /opt/dwm/
cd /opt/dwm/
patch < dwm-systray-6.0.diff  
make
make install

cd /opt/
git clone http://git.suckless.org/dmenu
cd dmenu
make
make install

cd /opt/
git clone http://git.suckless.org/dwmstatus
cd dwmstatus
make
make install

apt-get purge nano -y
apt-get autoremove -y
apt-get autoclean
apt-get clean
mkdir /mnt/samsung/

reboot
