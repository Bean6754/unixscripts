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

## Make sure free, non-free and contrib are enabled.
dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y

# Low-level
apt install -y aptitude git curl wget vim emacs sudo fakeroot p7zip-full zip unzip strace lsof htop nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump
# High-level
# Find Qt alternative for gparted, geany and filezilla
apt install -y wireshark-qt transmission-qt transmission-cli krita mpv libdvdnav4 libdvdread4 libdvdcss2 libbluray2 redshift quassel firefox-esr firefox-esr-l10n-en-gb
dpkg-reconfigure libdvd-pkg
# Flash player.
apt install -y browser-plugin-freshplayer-pepperflash
# Qt development.
apt install -y qt5-default qtdeclarative5-dev qml-module-qtquick-xmllistmodel
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk icedtea-8-plugin
