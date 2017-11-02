#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Disable PC Speaker now and at bootup.
rmmod pcspkr
mkdir -p /etc/modprobe.d
touch /etc/modprobe.d/pcspkr.conf
echo 'blacklist pcspkr' > /etc/modprobe.d/pcspkr.conf

# rm -rf /etc/apt/sources.list
# cp -r sources.list /etc/apt/sources.list

apt update -y
dpkg --add-architecture i386
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install -y firmware-linux* sudo ssh vim git wget curl build-essential devscripts fakeroot lua5.3 open-cobol gfortran-6 aptitude p7zip-full rar unrar unzip zip openjdk-8-jdk ffmpeg net-tools cifs-utils htop scrot libdvdread4 libdvdnav4 libdvdcss2 transmission-gtk nmap steam gtk2-engines-murrine murrine-themes gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-base-apps gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly qt5-default wireshark-gtk zenmap handbrake-cli handbreak 
# NOTE. You'll have to install nvidia drivers, intel microcode, amd64-microcode, etc.., yourself.
dpkg-reconfigure libdvd-pkg

# xfpanel-switch
apt install -y intltool intltool-debian
wget https://launchpad.net/xfpanel-switch/1.0/1.0.4/+download/xfpanel-switch-1.0.4.tar.bz2
tar xvf xfpanel-switch-1.0.4.tar.bz2
cd xfpanel-switch-1.0.4
make
make install
cd ..
rm -rf xfpanel-switch-1.0.4*

git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch

while true; do
   read -p "Do you want to compile the latest kernel? NOTE: This could take a few hours on older systems." yn
   case $yn in
      [Yy]* ) mkdir -p /usr/src && cd /usr/src/ && curl https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.11.tar.xz -o linux-4.11.tar.xz && tar -xvf linux-4.11.tar.xz && rm -rf linux-4.11.tar.xz && cd linux-4.11 && apt install -y ncurses-dev && make menuconfig && make && make modules_install && make install && break;;
      [Nn]* ) exit;;
      * ) echo "Please answer yes or no.";;
   esac
done

clear
neofetch
