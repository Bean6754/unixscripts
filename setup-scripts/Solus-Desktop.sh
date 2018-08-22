#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# dc = delete-cache
# up = upgrade
# it = install

eopkg dc
eopkg up -y
eopkg it -y -c system.devel
eopkg it -y cmus curl emacs git htop lsof neofetch nmap strace tcpdump vim wget wine wine-32bit
# nvidia-glx-driver-current
eopkg it -y audacity gimp lutris pavucontrol putty redshift steam virtualbox-current mpv wireshark
# Codecs.
eopkg it -y libbluray libdvdcss libdvdnav libdvdread
# Google Chrome.
eopkg bi --ignore-safety https://raw.githubusercontent.com/solus-project/3rd-party/master/network/web/browser/google-chrome-stable/pspec.xml
eopkg it google-chrome-*.eopkg
rm google-chrome-*.eopkg

eopkg dc
