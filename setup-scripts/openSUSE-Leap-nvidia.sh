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

zypper addrepo --refresh http://http.download.nvidia.com/opensuse/leap/15.0 NVIDIA

clear
echo On the next command, type 'a' and press enter.
echo Then on the licensing pages press 'q', then type yes. Twice!
sleep 4

zypper install-new-recommends
