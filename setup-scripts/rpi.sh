#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

## NOTE: This is a very personal setup, just like all of my other scripts.

# Personal instructions.
# 1. Setup static IP though `/etc/dhcpcd.conf`.
# 2. Install packages.
# 3. Setup lighttpd config.

# Low-level.
apt install -y aptitude neofetch git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip scanmem strace lsof htop screen tmux nmap build-essential ruby tshark lua5.3 gdisk tftp ftp tcpdump transmission-cli transmission-daemon net-tools nethogs iftop software-properties-common ntp exif imagemagick lm-sensors hddtemp tree

# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam

# Server specific.
apt install -y nginx mariadb-server php7.0-fpm php7.0-mysql php7.0-xml certbot python-certbot-apache # Replaced lighttpd with nginx for my setup.

systemctl enable nginx
systemctl start nginx

# lighttpd-enable-mod fastcgi
# lighttpd-enable-mod fastcgi-php
# a2enmod proxy_fcgi setenvif
# a2enconf php7.0-fpm
# a2enmod ssl
# a2ensite default-ssl.conf
systemctl restart nginx
systemctl reload nginx

systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation

systemctl enable php7.0-fpm
systemctl start php7.0-fpm

systemctl enable deluged
systemctl start deluged

# Certbot (LetsEncrypt)
certbot --authenticator webroot --installer nginx
# certbot certonly --authenticator standalone --pre-hook "apachectl -k stop" --post-hook "apachectl -k start"
