#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Disable PC Speaker now and at bootup.
rmmod pcspkr
mkdir -p /etc/modprobe.d
touch /etc/modprobe.d/pcspkr.conf
echo 'blacklist pcspkr' > /etc/modprobe.d/pcspkr.conf
