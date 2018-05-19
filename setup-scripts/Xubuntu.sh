#!/bin/bash

# For Kubuntu 18.04.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
apt update
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y

# Low-Level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk tshark tcpdump nmap transmission-cli hddtemp lm-sensors neofetch scanmem tmux ufw net-tools ssh ufw
# High-Level.
apt install -y bleachbit gimp mpv steam wine32-development wine64-development wireshark-gtk transmission transmission-gtk gparted baobab glade geany geany-plugins libbluray2 libdvdcss2 libdvdnav4 libdvdread4 xubuntu-restricted-extras xubuntu-restricted-addons gameconqueror kdenlive libreoffice libreoffice-l10n-en-gb pavucontrol redshift redshift-gtk simplescreenrecorder guvcview kdenlive virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
apt install -y playonlinux # Install after 'wine32-development' and 'wine64-development', just in case.
dpkg-reconfigure libdvd-pkg
# Themes.
apt install -y arc-theme chameleon-cursor-theme moka-icon-theme
# Skype.
curl -LO https://go.skype.com/skypeforlinux-64.deb
dpkg -i skypeforlinux-64.deb
apt install -fy
rm -rf skypeforlinux-64.deb
# Discord.
curl -LO "https://discordapp.com/api/download?platform=linux&format=deb"
mv 'download?platform=linux&format=deb' discord-0.0.5.deb
dpkg -i discord-0.0.5.deb
apt install -fy
rm -rf discord-0.0.5.deb
