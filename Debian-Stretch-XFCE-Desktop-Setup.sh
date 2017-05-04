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

rm -rf /etc/apt/sources.list
cp -r sources.list /etc/apt/sources.list

apt update -y
dpkg --add-architecture i386
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install -y *firmware* sudo ssh neovim git wget curl build-essential devscripts fakeroot lua5.3 open-cobol gfortran-6 aptitude p7zip-full rar unrar unzip zip openjdk-8-jdk ffmpeg net-tools cifs-utils htop scrot libdvdread4 libdvdnav4 libdvdcss2 transmission-gtk nmap steam gtk2-engines-murrine murrine-themes gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-base-apps gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly qt5-default wireshark-gtk zenmap handbrake-cli handbreak 
# NOTE. You'll have to install nvidia drivers, intel microcode, amd64-microcode, etc.., yourself.
dpkg-reconfigure libdvd-pkg

git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch

clear
neofetch
