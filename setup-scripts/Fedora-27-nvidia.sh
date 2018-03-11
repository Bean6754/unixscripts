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
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-nvidia.repo
# Install drivers and CUDA.
dnf install -y nvidia-driver nvidia-xconfig nvidia-settings kernel-devel akmod-nvidia vulkan vulkan.i686 nvidia-driver-libs nvidia-driver-libs.i686 cuda nvidia-driver-cuda cuda-devel cuda-cudart
# Autoremove any unneeded dependancies.
dnf autoremove -y

# Most likely not needed after a reboot.
# echo 'omit_drivers+="nouveau"' > /etc/dracut.conf.d/blacklist-nouveau.conf
# mkinitrd --force /boot/initramfs-$(uname -r).img $(uname -r)
# reboot

clear
echo "RUN: '/usr/sbin/akmods --force', AFTER a REBOOT. In order to rebuild initramfs after nouveau is disabled."
