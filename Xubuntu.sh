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

# Update system.
apt update -y
apt upgrade -y
apt dist-upgrade -y

# Low-Level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox build-essential tshark tcpdump transmission-cli
# High-Level.
apt install -y gimp parole wireshark-gtk transmission-gtk redshift redshift-gtk libdvdcss2 libdvdnav4 libdvdread4 openjdk-9-jdk xubuntu-restricted-extras xubuntu-restricted-addons

git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch
