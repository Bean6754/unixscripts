#!/bin/bash

# To use for LinuxMint 19 - Tara.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
apt update
apt dist-upgrade -y
apt upgrade -y
apt full-upgrade -y
apt autoremove -y

# Low-level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk transmission-cli hddtemp lm-sensors neofetch scanmem tmux
# Fun.
apt install -y figlet toilet lolcat cowsay cowsay-off
# Networking tools.
apt install -y tshark tcpdump nmap ufw net-tools ssh iptables iptables-persistent
systemctl enable netfilter-persistent
systemctl start netfilter-persistent
# High-level.
apt install -y bleachbit gimp mpv vlc steam wine32-development wine64-development wireshark-gtk gufw transmission transmission-gtk gparted baobab glade geany geany-plugins libbluray2 libdvdcss2 libdvdnav4 libdvdread4 ubuntu-restricted-extras ubuntu-restricted-addons mint-meta-codecs gameconqueror kdenlive libreoffice libreoffice-l10n-en-gb pavucontrol redshift redshift-gtk simplescreenrecorder guvcview kdenlive virtualbox virtualbox-qt virtualbox-ext-pack virtualbox-guest-additions-iso skypeforlinux
apt install -y playonlinux # Install after 'wine32-development' and 'wine64-development', just in case.
apt install -y chromium pepperflashplugin-nonfree
apt purge -y firefox && apt autoremove -y
dpkg-reconfigure libdvd-pkg
# Themes.
apt install -y oxygen-cursor-theme
# Fonts.
apt install -y ttf-mscorefonts-installer ttf-dejavu fonts-liberation fonts-liberation2 fonts-noto
# Discord.
curl -LO "https://discordapp.com/api/download?platform=linux&format=deb"
mv 'download?platform=linux&format=deb' discord-0.0.5.deb
dpkg -i discord-0.0.5.deb
apt install -fy
rm -rf discord-0.0.5.deb
