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

systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl start wpa_supplicant
systemctl disable wpa_supplicant

pkill NetworkManager
pkill wpa_supplicant

rm -rf /etc/wpa_supplicant
echo 'network={' > /etc/wpa_supplicant/wpa_supplicant.conf
echo 'ssid="leap-example"' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'key_mgmt=IEEE8021X' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'eap=LEAP' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'identity="user"' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo 'password="foobar"' >> /etc/wpa_supplicant/wpa_supplicant.conf
echo '}' >> /etc/wpa_supplicant/wpa_supplicant.conf

wpa_supplicant -iwlo1 -c/etc/wpa_supplicant/wpa_supplicant.conf&

exit 0
