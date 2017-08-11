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

## Repositories.

# RPM Fusion: (Optional, not needed.)
# dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Negativo1 multimedia: (Has nvidia drivers with it.)
dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo -y
# Negativo1 steam: 
dnf config-manager --add-repo=http://negativo17.org/repos/fedora-steam.repo -y

## Packages.

# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y development-tools security-lab
# Singular packages.
dnf install -y git wget curl htop nmap ruby gem gcc gcc-c++ python perl java-1.8.0-openjdk java-1.8.0-openjdk-devel gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free gstreamer1-plugins-bad-freeworld gstreamer1-plugins-bad-free-extras ffmpeg libdvdnav libdvdread libdvdcss steam libreoffice gimp vim firefox transmission transmission-cli transmission-gtk iftop

# Enable firewalld at boot (and start it).
systemctl enable firewalld && systemctl start firewalld
firewall-cmd --runtime-to-permanent
firewalld

exit 0
