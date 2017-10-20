#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
yum update -y
# Install stuff.
yum install -y epel-release
yum update -y
yum install -y dnf microcode_ctl kernel-devel zip unzip p7zip p7zip-plugins git wget curl htop strace lsof nc tcpdump net-tools libbluray firefox libreoffice firewall-config pulseaudio alsa-plugins-pulseaudio alsa-utils dvd+rw-tools pulseaudio-module-x11 pulseaudio-utils pavucontrol
yum groupinstall -y "X Window system" "Xfce" "Development Tools"

# Start GDM or Lightdm at boot.
systemctl set-default graphical.target

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch

# Exit script.
exit 0
