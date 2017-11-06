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

# Update system.
yum update -y
# Install stuff.
yum install -y epel-release
yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm
yum update -y
yum install -y dnf microcode_ctl kernel-devel dkms zip unzip p7zip p7zip-plugins git wget curl htop strace lof nc tcpdump net-tools libbluray firefox libreoffice firewall-config pulseaudio alsa-plugins-pulseaudio alsa-utils dvd+rw-tools pulseaudio-module-x11 pulseaudio-utils pavucontrol xarchiver mousepad gimp vlc vlc-extras qt5-qtbase qt5-qtconfiguration transmission transmission-cli wireshark wireshark-gnome
yum groupinstall -y "X Window system" "Xfce" "Development Tools"
# XFCE4 extras.
yum install -y xfce4-*-plugin xfce4-about xfce4-vala

# Steam.
# Dependancies.
# yum install mesa-libGL mesa-libGLES mesa-libGLU mesa-libGLw mesa-libEGL mesa-libGL.i686 mesa-libGLES.i686 mesa-libGLU.i686 mesa-libGLw.i686 mesa-libEGL.i686
# wget http://repo.steampowered.com/steam/archive/precise/steam_latest.tar.gz
# tar xvf steam_latest.tar.gz
# cd steam
# make install
# cd ..
# rm -rf steam

# Start GDM or Lightdm at boot.
systemctl set-default graphical.target

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch

# Exit script.
exit 0
