#!/bin/csh

su -m root -c 'pkg update'
su -m root -c 'pkg upgrade -y'

# https://www.textfixer.com/tools/alphabetize-text-words.php
# Low-level.
su -m root -c 'pkg install -y curl git ImageMagick neofetch p7zip rar sudo tmux unrar unzip vim-console wget zip'

#echo 'proc /proc procfs rw,noauto 0 0' >> /etc/fstab

#echo 'linux_enable="YES"' >> /etc/rc.conf
