#!/bin/csh

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Check date and time first!
ntpdate -s time.nist.gov

freebsd-update fetch install

# Ports take up too much space, extraction time and compile time.
# portsnap fetch
# portsnap extract
# portsnap update

pkg update
pkg upgrade -y

# https://www.textfixer.com/tools/alphabetize-text-words.php
# Low-level.
pkg install -y curl git htop neofetch p7zip rar sudo tmux unrar unzip vim-lite wget zip
# Networking.
pkg install -y nmap tshark
# Server.
pkg install -y nginx

# Linux emulation not availible for aarch64 (RPi).
# echo 'proc /proc procfs rw,noauto 0 0' >> /etc/fstab
# echo 'linux_enable="YES"' >> /etc/rc.conf
