#!/bin/bash

# up = upgrade
# it = install

eopkg up -y
eopkg it -y -c system.devel
eopkg it -y emacs neofetch nmap tcpdump vim wine wine-32bit
# nvidia-glx-driver-current
eopkg it -y audacity gimp lutris pavucontrol putty redshift steam virtualbox-current wireshark
eopkg it -y lugaru
