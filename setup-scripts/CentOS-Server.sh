#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
yum update -y
# Install stuff.
yum install -y epel-release
yum update -y
yum groupinstall -y "Development Tools"
yum install -y dnf microcode_ctl kernel-devel zip unzip p7zip p7zip-plugins git wget curl htop strace lsof nc tcpdump vim emacs-nox nethogs iftop

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
