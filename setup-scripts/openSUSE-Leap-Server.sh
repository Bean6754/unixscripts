#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
zypper ref
zypper up -y
zypper dup -y

# Install development tools.
zypper install -t pattern devel_basis
zypper install -y lsb-release make cmake git curl wget lsof strace htop vim emacs-nox python2 python3 ruby gcc gcc-c++ lua tcl java-11-openjdk java-11-openjdk-devel qbittorrent-nox

# Networking tools.
zypper in -y wireshark tcpdump nmap ufw whois

# LAMP.
zypper in -y apache2 php7 php7-mysql apache2-mod_php7 mariadb mariadb-tools

rcmysql start
/usr/bin/mysql_secure_installation

systemctl enable apache2
systemctl start apache2
a2enmod php7
systemctl restart apache2
systemctl enable mariadb
systemctl restart mariadb

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
