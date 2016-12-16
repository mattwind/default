#!/usr/bin/env bash
user=$1

if [ "$user" == "" ];
then
	echo "No user specified"
	exit 1
fi

echo "Install Git"
apt-get install git -y 

echo "Clone default project"
cd /tmp
git clone https://github.com/mattwind/default.git

echo "Apt Update"
cp /tmp/default/apt/jessie /etc/apt/sources.list
apt-get update
apt-get upgrade -y

echo "Install Packages"
apt-get install `cat /tmp/default/apt/packages.list` -y

echo "Add $user to fuse group"
groupadd fuse
adduser $user fuse
chown root.$user /dev/fuse
chmod 660 /dev/fuse

echo "Add $user to sudoers"
usermod -a -G sudo $user

echo "Extract dwm source"
tar -xf /tmp/default/dwm/dwm-6.0.tar.gz -C /opt/
ln -s /opt/dwm-6.0/ /opt/dwm/
cp /tmp/dwm/dwm-systray-6.0.diff /opt/dwm/
cd /opt/dwm/

echo "Add systray patch"
patch < dwm-systray-6.0.diff  

echo "Compile dwm"
make
make install

echo "Setup dmenu"
cd /opt/
git clone http://git.suckless.org/dmenu
cd dmenu
make
make install

echo "Setup dwmstatus"
cd /opt/
git clone http://git.suckless.org/dwmstatus
cd dwmstatus
make
make install

echo "Clean up"
apt-get purge nano -y
apt-get autoremove -y
apt-get autoclean
apt-get clean
mkdir /mnt/samsung/

echo "Reboot"
reboot
