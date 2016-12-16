#!/usr/bin/env bash
user=$1

if [ "$user" == "" ];
then
	echo "No user specified"
	exit 1
fi

echo "Install Git"
apt-get install git -y >/dev/null

echo "Clone default project"
cd /tmp
git clone https://github.com/mattwind/default.git >/dev/null

echo "Apt Update"
cp /tmp/default/apt/jessie /etc/apt/sources.list >/dev/null
apt-get update >/dev/null
apt-get upgrade -y >/dev/null

echo "Install Packages"
apt-get install `cat apt/packages.list` -y >/dev/null

echo "Add $user to fuse group"
groupadd fuse >/dev/null
adduser $user fuse >/dev/null
chown root.$user /dev/fuse >/dev/null
chmod 660 /dev/fuse >/dev/null

echo "Add $user to sudoers"
usermod -a -G sudo $user >/dev/null

echo "Extract dwm source"
tar -xf /tmp/default/dwm/dwm-6.0.tar.gz -C /opt/ >/dev/null
cp /tmp/dwm/dwm-systray-6.0.diff /opt/dwm-6.0/ >/dev/null
cd /opt/dwm-6.0/
ln -s /opt/dwm-6.0/ /opt/dwm/ >/dev/null

echo "Add systray patch"
patch < dwm-systray-6.0.diff >/dev/null

echo "Compile dwm"
make >/dev/null
make install >/dev/null

echo "Setup dmenu"
cd /opt/
git clone http://git.suckless.org/dmenu >/dev/null
cd dmenu
make >/dev/null
make install >/dev/null

echo "Setup dwmstatus"
cd /opt/
git clone http://git.suckless.org/dwmstatus >/dev/null
cd dwmstatus
make >/dev/null
make install >/dev/null

echo "Clean up"
apt-get purge nano -y >/dev/null
apt-get autoremove -y >/dev/null
apt-get autoclean >/dev/null
apt-get clean >/dev/null
mkdir /mnt/samsung/

echo "Reboot"
reboot
