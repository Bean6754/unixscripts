#!/bin/bash

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
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk tshark tcpdump nmap qbittorrent-nox hddtemp lm-sensors neofetch scanmem tmux ufw
# High-Level.
apt install -y bleachbit krita inkscape inkscape-open-symbols vlc wireshark-qt qbittorent partitionmanager qtcreator libbluray2 libdvdcss2 libdvdnav4 libdvdread4 kubuntu-restricted-extras kubuntu-restricted-addons gameconqueror kdenlive libreoffice libreoffice-l10n-en-gb pavucontrol-qt redshift plasma-applet-redshift-control simplescreenrecorder kdenlive virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso
dpkg-reconfigure libdvd-pkg
# Atom.
curl -LO https://atom.io/download/deb
mv deb atom-amd64.deb
dpkg -i atom-amd64.deb
apt install -f
rm -rf atom-amd64.deb
# Themes.
apt install -y arc-theme oxygen-cursor-theme moka-icon-theme
