#!/bin/bash

# This script requires 'lm-sensors' and 'hddtemp' to be installed.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

while true
do
  clear
  
  # Use 'sensors -f' for fahrenheit instead of celsius.
  sensors
  hddtemp /dev/sda
  hddtemp /dev/sdb
  hddtemp /dev/sdc
  
  sleep 2
done
