#!/bin/csh

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo >> /etc/rc.conf
echo "# Custom." >> /etc/rc.conf
# Check date and time first!
# https://www.cyberciti.biz/tips/freebsd-timeclock-synchronization-with-ntp-server.html
ntpdate -s time.nist.gov
echo >> /etc/rc.conf
echo "# NTP." >> /etc/rc.conf
echo 'ntpdate_enable="YES"' >> /etc/rc.conf
echo 'ntpdate_hosts="time.nist.gov"' >> /etc/rc.conf

freebsd-update fetch install

# Ports take up too much space, extraction time and compile time.
# portsnap fetch
# portsnap extract
# portsnap update

pkg update -y     # To fetch 'pkg'.
pkg update        # To update system.
pkg upgrade -y    # To upgrade all system packages.

# https://www.textfixer.com/tools/alphabetize-text-words.php
# Low-level.
pkg install -y curl git htop neofetch p7zip sudo tmux unrar unzip vim-console wget zip
# Networking.
pkg install -y nmap tshark
# To download free GeoIP databases.
/usr/local/bin/geoipupdate.sh
# Server.
# https://www.digitalocean.com/community/tutorials/how-to-install-an-nginx-mysql-and-php-femp-stack-on-freebsd-10-1
pkg install -y mariadb102-server nginx php72 php72-mysqli
echo >> /etc/rc.conf
echo '# Web server.' >> /etc/rc.conf
echo 'mysql_enable="YES"' >> /etc/rc.conf
echo 'nginx_enable="YES"' >> /etc/rc.conf
echo 'php_fpm_enable="YES"' >> /etc/rc.conf
service mysql-server onestart
mysql_secure_installation


# Linux emulation not availible for aarch64 (RPi).
# echo 'proc /proc procfs rw,noauto 0 0' >> /etc/fstab
# echo 'linux_enable="YES"' >> /etc/rc.conf
