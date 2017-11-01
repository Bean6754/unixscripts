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
# ...

# Set timezone
rm -R /etc/timezone
ln -s /usr/share/Europe/London /etc/timezone

# Set hwclock to UTC.
hwclock --utc

# Date timestamp.
datestamp() {
  date +"%D"
}
echo 'The date is' & datestamp

# Enable root access.
su

systemctl enable dhcpcd.service
systemctl start dhcpcd.service
# Check internet connectivity


cd /etc/
cp -r pacman.conf pacman.conf.old
curl (insert pacman.conf url here) -o pacman.conf
pacman -Syyu
pacman -S xorg xorg-xinit i3 yaourt aurvote customizepkg rsync

# Disable root access for the AUR.
exit

yaourt -S cower-git pacaur-git
pacaur -Rsnc yaourt
pacaur -S vlc libdvdcss links ranger w3m ttf-liberation ttf-dejavu ttf-freefont i3blocks lemonbar-git feh git curl wget htop strace lsof

# Change to user home folder.
cd ~/
touch .xinitrc
echo 'exec i3' > .xinitrc
echo 'startx' >> .bashrc



# i3 stuff.
cd ~/config/.i3/
curl (insert i3 'config' url here) -o config
curl (inser i3blocks.conf url here) -o i3blocks.conf