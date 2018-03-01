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

## Make sure free, non-free and contrib are enabled.
dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y
apt full-upgrade -y
apt autoremove -y

# Low-level
apt install -y aptitude git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip strace lsof htop nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli nethogs iftop
# High-level
apt install -y wireshark-gtk transmission-gtk pavucontrol xarchiver geany geany-plugins filezilla gparted gimp redshift pidgin firefox-esr firefox-esr-l10n-en-gb mugshot
# Codecs
apt install -y ffmpeg libdvdnav4 libdvdread4 libdvdcss2 libbluray2
dpkg-reconfigure libdvd-pkg
# Flash player.
apt install -y browser-plugin-freshplayer-pepperflash
# Emoji and other fonts.
apt install -y fonts-noto-color-emoji fonts-symbola fonts-liberation fonts-liberation2 ttf-mscorefonts-installer fonts-dejavu fonts-noto
# Themes.
apt install -y moka-icon-theme chameleon-cursor-theme darkcold-gtk-theme xfwm4-themes
# Remove VLC and install mpv
apt purge -y vlc && apt autoremove -y && apt purge -y libqt5core5a libqt5gui5 vlc-plugin-qt && apt autoremove -y
apt install -y mpv
# Qt development.
# apt install -y qt5-default qtdeclarative5-dev qml-module-qtquick-xmllistmodel
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk icedtea-8-plugin
