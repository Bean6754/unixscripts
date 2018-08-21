#!/bin/bash

# dc = delete-cache
# up = upgrade
# it = install

eopkg dc
eopkg up -y
eopkg it -y -c system.devel
eopkg it -y curl emacs git htop lsof neofetch nmap strace tcpdump vim wget wine wine-32bit
# nvidia-glx-driver-current
eopkg it -y audacity gimp lutris pavucontrol putty redshift steam virtualbox-current wireshark
eopkg dc
