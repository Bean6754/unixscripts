#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Low-level.
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip scanmem strace lsof htop screen tmux nmap build-essential ruby tshark lua5.3 gdisk tftp ftp tcpdump transmission-cli transmission-daemon net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp

# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam

# Server specific.
apt install -y lighttpd mariadb-server php7.0-fpm php7.0-mysql php7.0-xml

systemctl enable lighttpd
systemctl start lighttpd

lighttpd-enable-mod fastcgi
lighttpd-enable-mod fastcgi-php
service lighttpd force-reload

systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation

systemctl enable php7.0-fpm
systemctl start php7.0-fpm
