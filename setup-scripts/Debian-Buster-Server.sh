#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

## Make sure free, non-free and contrib are enabled.
dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y
apt autoremove -y

# Low-level
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common ntp exif imagemagick
# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk
# Server specific stuff.
systemctl stop apache2
apt install -y mariadb-server mariadb-client php7.2 php-pear php7.2-fpm php7.2-mysql nginx
systemctl disable apache2
systemctl enable nginx
systemctl enable mariadb
mysql_secure_installation
