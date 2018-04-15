#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
yum update -y
# Repos.
yum install -y epel-release
yum-config-manager --add-repo=https://negativo17.org/repos/epel-multimedia.repo
yum-config-manager --add-repo=https://negativo17.org/repos/epel-nvidia.repo
yum-config-manager --add-repo=https://negativo17.org/repos/epel-steam.repo
yum update -y
# Low-level.
yum install -y microcode_ctl kernel-devel zip unzip p7zip p7zip-plugins git wget curl htop strace lsof nc tcpdump vim emacs-nox nethogs iftop
# Groupinstall.
yum groupinstall -y "Development Tools"
# High-level.
yum install -y libbluray firewall-config dvd+rw-tools pavucontrol gimp transmission transmission-cli wireshark wireshark-gnome redshift redshift-gtk pidgin geany firefox filezilla recordmydesktop gtk-recordmydesktop
# Fonts.
yum install -y liberation-fonts-common dejavu-fonts-common google-noto-fonts-common google-noto-emoji-fonts
# Themes.
yum install -y adapta-gtk-theme arc-theme numix-icon-theme numix-icon-theme-circle paper-icon-theme steamos-backgrounds
# Repo based.
# nvidia is broken :(
yum install -y nvidia-driver kernel-devel dkms-nvidia nvidia-driver-libs nvidia-driver-libs.i686 nvidia-xconfig nvidia-settings cuda nvidia-driver-cuda cuda-devel cuda-cudart
yum install -y steam mpv

# Steam.
# Dependancies.
# yum install mesa-vdpau-drivers mesa-vulkan-drivers mesa-libGLw mesa-libGLw.i686 mesa-libEGL mesa-libEGL.i686 mesa-libGL mesa-libGL.i686 mesa-libGLES mesa-libGLES.i686 mesa-libGLU mesa-libGLU.i686 mesa-libGLw mesa-libGLw.i686 libtxc_dxtn libtxc_dxtn.i686 zenity
# wget http://repo.steampowered.com/steam/archive/precise/steam_latest.tar.gz
# tar xvf steam_latest.tar.gz
# cd steam
# make install
# cd ..
# rm -rf steam

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
