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
# ...

# Disable and stop network services.
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl disable netctl
systemctl stop netctl
systemctl disable wpa_supplicant
systemctl stop wpa_supplicant

# Set WiFi interface to down.
ip link set wlp2s0 down
# Start WiFi-Menu to do all of the WiFi for us.
wifi-menu
# Exit program sucessfully.
exit 0
