#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

rm -rf /Library/Caches/*
rm -rf /var/root/Library/Caches/*
rm -rf /Users/*/Library/Caches/*
