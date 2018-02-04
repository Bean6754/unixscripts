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
yum install -y dnf microcode_ctl kernel-devel dkms zip unzip p7zip p7zip-plugins git wget curl htop strace lsof nc tcpdump vim emacs-nox libbluray chromium libreoffice firewall-config pulseaudio alsa-plugins-pulseaudio alsa-utils dvd+rw-tools pulseaudio-module-x11 pulseaudio-utils pavucontrol xarchiver mousepad gimp parole xfce4-netload-plugin xfce4-weather-plugin ristretto transmission transmission-cli wireshark wireshark-gnome redshift redshift-gtk pidgin geany
yum groupinstall -y "X Window system" "Development Tools" "Xfce"

# Steam.
# Dependancies.
# yum install mesa-vdpau-drivers mesa-vulkan-drivers mesa-libGLw mesa-libGLw.i686 mesa-libEGL mesa-libEGL.i686 mesa-libGL mesa-libGL.i686 mesa-libGLES mesa-libGLES.i686 mesa-libGLU mesa-libGLU.i686 mesa-libGLw mesa-libGLw.i686 libtxc_dxtn libtxc_dxtn.i686 zenity
# wget http://repo.steampowered.com/steam/archive/precise/steam_latest.tar.gz
# tar xvf steam_latest.tar.gz
# cd steam
# make install
# cd ..
# rm -rf steam

# Start GDM or Lightdm at boot.
yum remove -y gdm
yum install -y lightdm
systemctl set-default graphical.target
systemctl enable lightdm

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
