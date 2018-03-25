#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
apt update
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y

# Low-Level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk tshark tcpdump nmap transmission-cli scanmem
# High-Level.
apt install -y gimp mpv wireshark-gtk transmission-gtk gparted geany geany-plugins glade libbluray2 libdvdcss2 libdvdnav4 libdvdread4 ubuntu-restricted-extras ubuntu-restricted-addons gameconqueror gnome-tweak-tool kdenlive libreoffice libreoffice-l10n-en-gb simplescreenrecorder virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
dpkg-reconfigure libdvd-pkg
