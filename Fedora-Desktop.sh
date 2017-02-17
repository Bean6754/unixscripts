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

# RPM Fusion: 
dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Negativo1 multimedia: 
dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo -y

dnf update -y 
dnf install -y ruby gem gcc gcc-c++ python perl java-1.8.0-openjdk java-1.8.0-openjdk-devel gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-bad-free gstreamer1-plugins-bad-freeworld gstreamer1-plugins-bad-free-extras ffmpeg vlc libdvdnav libdvdread libdvdcss steam libreoffice gimp emacs-nox firefox transmission-cli transmission-gtk qt5 qt5-designer gtk2 gtk3 glade

exit 0
