#!/bin/sh

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
apt install -y aptitude git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip strace lsof htop nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk
# Server specific stuff.
apt install -y mariadb-server mariadb-client php7.1 php7.1-mysql

exit 0