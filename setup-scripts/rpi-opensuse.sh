#!/bin/bash

# For: openSUSE Tumbleweed (current) - Raspberry Pi 3 B+.
# Do not use the JeOS image!! Networking does not work on it.
# http://download.opensuse.org/ports/aarch64/tumbleweed/images/openSUSE-Tumbleweed-ARM-XFCE-raspberrypi3.aarch64-Current.xz
# http://download.opensuse.org/ports/aarch64/tumbleweed/images/

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Fix filesystem fix.
# Extend root partition size to max.
resize2fs /dev/mmclk0p2

# Update system.
zypper ref
zypper up -y
zypper dup -y

