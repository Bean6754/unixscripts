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

rm -rf /etc/apt/sources.list
cp -r sources.list /etc/apt/sources.list

apt update -y
dpkg --add-architecture i386
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install -y firmware-linux sudo vim git wget curl build-essential openjdk-8-jdk ffmpeg net-tools libdvdcss2 transmission-gtk nmap steam gtk2-engines-murrine murrine-themes gstreamer1.0-*

# NOTE. You'll have to install nvidia drivers, intel microcode, amd64-microcode, etc.., yourself.

git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch

clear
neofetch
