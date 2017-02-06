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

apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install -y aptitude vim wget curl git build-essential vlc libdvdcss2 libdvdnav4 libdvdread4 qt5-default

add-apt-repository -y ppa:kdenlive/kdenlive-stable
apt update -y
apt install -y kdenlive

git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch

exit 0
