#!/bin/bash

# This is a temporary fix for the GNOME 3 memory leak.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

while (true)
do
  killall -3 gnome-shell
  sleep 60
done
