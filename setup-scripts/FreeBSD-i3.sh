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
pkg install -y curl deb2targz doas git ImageMagick linux-c7 neofetch p7zip rar rpm2cpio sudo tmux unrar unzip vim-tiny wget zip
# High-level.
pkg install -y chromium libbluray libdvdcss libdvdnav libdvdread playonbsd vlc x11/kde4 xinit xorg

echo >> /boot/loader.conf
echo 'loader_logo="beastie"' >> /boot/loader.conf

echo >> /etc/fstab
echo 'proc /proc procfs rw,noauto 0 0' >> /etc/fstab

echo 'linux_enable="YES"' >> /etc/rc.conf
echo 'dbus_enable="YES"' >> /etc/rc.conf
echo 'hald_enable="YES"' >> /etc/rc.conf
echo 'kdm4_enable="YES"' >> /etc/rc.conf

# NVIDIA-Driver Stuff.
# kldload linux
# kldload linux64
# pkg install -y nvidia-driver nvidia-settings nvidia-texture-tools nvidia-xconfig
# echo 'nvidia_load="YES"' >> /boot/loader.conf
# echo 'nvidia_name="nvidia"' >> /boot/loader.conf
# echo 'nvidia_modeset_load="YES"' >> /boot/loader.conf
# echo 'nvidia_modeset_name="nvidia-modeset"' >> /boot/loader.conf
