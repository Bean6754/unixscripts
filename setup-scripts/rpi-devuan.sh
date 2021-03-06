#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

## NOTE: This is a very personal setup, just like all of my other scripts.

# Remember, when writing to files, copy the original as 'name.old'.
# Personal instructions.
# 1.  Change root password from 'toor' to anything else. >__>
# 2.  Setup static IP though `/etc/network/interfaces`. (Copy to `"".old`.)
# 3.  Restart networking via `service networking stop ; service networking start` (restart is depreciated).
# 4.  Relogin via new IP over SSH.
# 5.  Add a user (`adduser bean`).
# 6.  Add user to `/etc/sudoers`. (Copy to `"".old`.)
# 7.  Disable root login over SSH. (Copy `/etc/ssh/sshd_config` to `/etc/ssh/sshd_config.old`.)
# 8.  Restart SSH: `service ssh restart`.
# 9.  Install packages.
# 10. Setup apache2 config.

# Update system.
apt update
apt dist-upgrade -y
apt upgrade -y
apt full-upgrade -y
apt autoremove -y

# Low-level.
apt install -y man-db aptitude neofetch git curl wget vim emacs-nox sudo p7zip-full zip unzip scanmem strace htop screen tmux nmap build-essential tshark gdisk tftp ftp tcpdump transmission-cli transmission-daemon net-tools nethogs iftop ntp lm-sensors hddtemp tree ufw

# Security.
apt install -y clamav chkrootkit rkhunter lynis
freshclam

# Server specific.
apt install -y apache2 mariadb-server php7.0-fpm php7.0-mysql certbot python-certbot-apache

update-rc.d apache2 defaults
service apache2 start
# systemctl enable apache2
# systemctl start apache2

# Lighttpd.
# lighttpd-enable-mod fastcgi
# lighttpd-enable-mod fastcgi-php
# Apache.
a2enmod proxy_fcgi setenvif
a2enconf php7.0-fpm
a2enmod ssl
a2ensite default-ssl.conf
service apache2 restart
# systemctl reload apache2
# systemctl restart apache2
# nginx.
# systemctl restart nginx
# systemctl reload nginx

systemctl enable mariadb
systemctl start mariadb

mysql_secure_installation

systemctl enable php7.0-fpm
systemctl start php7.0-fpm

systemctl enable transmission-daemon
systemctl start transmission-daemon

# Certbot (LetsEncrypt)
certbot --authenticator webroot --installer apache
# certbot certonly --authenticator standalone --pre-hook "apachectl -k stop" --post-hook "apachectl -k start"
