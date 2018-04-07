#!/bin/bash

# Make sure user is running script, not root!
if [[ $EUID -ne 0 ]]; then
   echo
else
  echo "You must not be root while running this script!"
  exit 1
fi

su -c 'pacman -Syyu'
su -c 'pacman -S xorg xorg-xinit i3 i3lock i3status yaourt aurvote customizepkg rsync'

yaourt -S cower-git pacaur-git
pacaur -Rsnc yaourt
pacaur -S vim scrot python2 python ruby perl lua tcl vlc-git qt5-base pulseaudio pulseaudio-alsa pavucontrol libdvdnav libdvdread libbluray libdvdcss p7zip zip unzip rxvt-unicode links ranger w3m ttf-liberation ttf-dejavu ttf-freefont dmenu rofi redshift i3blocks lemonbar-git feh git curl wget htop strace lsof
pacaur -S gimp gimp-help-en_gb libreoffice-fresh libreoffice-fresh-en-GB hunspell hunspell-en_GB firefox-developer-en-gb ffmpeg flashplayer-standalone jdk9-openjdk transmission-cli transmission-gtk skypeforlinux-bin weechat
# libva-vdpau-driver for nvidia and libva-intel-driver for Intel.
# For i3blocks.
pacaur -S acpi bc lm_sensors openvpn playerctl alsa-utils sysstat

touch ~/.xinitrc
echo 'exec i3' > ~/.xinitrc
echo 'startx' >> ~/.bashrc
