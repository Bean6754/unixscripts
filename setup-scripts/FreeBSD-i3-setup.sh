#!/bin/tcsh

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

portsnap fetch
portsnap extract
portsnap update

pkg update
pkg upgrade -y

# https://www.textfixer.com/tools/alphabetize-text-words.php
# Low-level.
pkg install -y curl git neofetch p7zip rar sudo unrar unzip vim-lite zip
# High-level.
pkg install -y feh firefox i3 i3lock i3status libbluray libdvdcss libdvdnav libdvdread mpv playonbsd rofi rxvt-unicode xarchiver xinit xorg

echo 'proc /proc procfs rw,noauto 0 0' >> /etc/fstab

echo 'linux_enable="YES"' >> /etc/rc.conf
echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf

# NVIDIA-Driver Stuff.
# kldload linux
# kldload linux64
# pkg install -y nvidia-driver nvidia-settings nvidia-texture-tools nvidia-xconfig
# echo 'nvidia_load="YES"' >> /boot/loader.conf
# echo 'nvidia_name="nvidia"' >> /boot/loader.conf
# echo 'nvidia_modeset_load="YES"' >> /boot/loader.conf
# echo 'nvidia_modeset_name="nvidia-modeset"' >> /boot/loader.conf
# echo 'kld_list="nvidia nvidia-modeset"' >> /etc/rc.conf
# echo 'nvidia_name="nvidia"' >> /etc/rc.conf
# echo 'nvidia_modeset_name="nvidia-modeset"' >> /etc/rc.conf
