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
apt install -y aptitude git curl wget vim emacs-nox sudo fakeroot p7zip-full zip unzip strace lsof htop screen tmux nmap build-essential ruby tshark intel-microcode lua5.3 gdisk tftp ftp tcpdump transmission-cli net-tools nethogs iftop software-properties-common
# High-level
apt install -y wireshark-gtk transmission-gtk vlc pavucontrol xarchiver menulibre geany geany-plugins glade baobab filezilla gparted gimp redshift redshift-gtk pidgin firefox-esr firefox-esr-l10n-en-gb thunderbird thunderbird-l10n-en-gb gpick software-properties-gtk synaptic gdebi conky-all guvcview simplescreenrecorder wmctrl
# Codecs
apt install -y ffmpeg libdvdnav4 libdvdread4 libdvdcss2 libbluray1
dpkg-reconfigure libdvd-pkg
# Flash player.
apt install -y browser-plugin-freshplayer-pepperflash
# Emoji and other fonts.
apt install -y fonts-noto fonts-noto-mono fonts-symbola ttf-ancient-fonts-symbola fonts-liberation fonts-liberation2 ttf-mscorefonts-installer fonts-dejavu fonts-dejavu-extra
# Themes.
apt install -y moka-icon-theme chameleon-cursor-theme xfwm4-themes
# Qt development.
apt install -y qt5-default qtcreator qtdeclarative5-dev qml-module-qtquick-xmllistmodel
# Java.
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-8-jdk icedtea-8-plugin
