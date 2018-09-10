#!/bin/bash

# For openSUSE Leap 15 - Raspberry Pi.

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
zypper dup -y
zypper up -y

