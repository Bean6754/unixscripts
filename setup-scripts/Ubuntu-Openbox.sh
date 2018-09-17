#!/bin/bash

# For Ubuntu Mini 18.04.

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
apt update
apt upgrade -y
apt autoremove -y

# Low-Level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk transmission-cli hddtemp lm-sensors neofetch scanmem tmux youtube-dl software-properties-common
# Networking tools.
apt install -y tshark tcpdump nmap ufw net-tools ssh iptables iptables-persistent
systemctl enable netfilter-persistent
systemctl start netfilter-persistent
# Install xorg and openbox.
apt install -y xorg xinit openbox
# High-Level.
apt install -y chromium-browser terminator bleachbit gimp mpv steam wine32-development wine64-development wireshark-qt gufw transmission transmission-qt gparted baobab glade qtcreator geany geany-plugins libbluray2 libdvdcss2 libdvdnav4 libdvdread4 ubuntu-restricted-extras ubuntu-restricted-addons gameconqueror kdenlive libreoffice libreoffice-l10n-en-gb pavucontrol-qt redshift simplescreenrecorder guvcview kdenlive virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso software-properties-gtk lxappearance
apt install -y playonlinux # Install after 'wine32-development' and 'wine64-development', just in case.
dpkg-reconfigure libdvd-pkg
# Themes.
apt install -y gtk2-engines-oxygen gtk3-engines-breeze oxygen-cursor-theme qt5-style-plugins
# echo "export QT_QPA_PLATFORMTHEME=gtk2" >> ~/.profile
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
