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
dnf update -y
# Install repo.
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Install drivers and CUDA.
dnf install -y xorg-x11-drv-nvidia akmod-nvidia xorg-x11-drv-nvidia-cuda
# Autoremove any unneeded dependancies.
dnf autoremove -y

# Most likely not needed after a reboot.
# echo 'omit_drivers+="nouveau"' > /etc/dracut.conf.d/blacklist-nouveau.conf
# mkinitrd --force /boot/initramfs-$(uname -r).img $(uname -r)
# reboot

clear
echo "RUN: '/usr/sbin/akmods --force', AFTER a REBOOT. In order to rebuild initramfs after nouveau is disabled."
