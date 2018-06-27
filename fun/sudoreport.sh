#!/bin/bash

# NOTE: This program requires systemd.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

journalctl | grep "NOT in sudoers"
