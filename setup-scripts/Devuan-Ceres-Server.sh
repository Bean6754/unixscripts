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

# Tasksel stuff.
# tasksel install print-server
# tasksel install ssh-server
# tasksel install web-server

# Low-level
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip rar unrar scanmem strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp
# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk
# Server specific stuff.
service apache2 stop
apt install -y mariadb-server mariadb-client php7.0 php-pear php7.0-fpm php7.0-mysql nginx
update-rc.d -f apache2 remove
update-rc.d php7.0-fpm defaults
update-rc.d nginx defaults
update-rc.d mysql defaults
mysql_secure_installation
