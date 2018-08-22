#!/bin/bash

# dc = delete-cache
# up = upgrade
# it = install

eopkg dc
eopkg up -y
eopkg it -y -c system.devel
eopkg it -y cmus curl emacs git htop lsof neofetch nmap strace tcpdump vim wget wine wine-32bit
# nvidia-glx-driver-current
eopkg it -y audacity deadbeef gimp lutris pavucontrol putty redshift steam virtualbox-current mpv wireshark
eopkg it -y libbluray libdvdcss libdvdnav libdvdread
eopkg dc
