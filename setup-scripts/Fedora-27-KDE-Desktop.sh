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

# Repos.
# Negativo17 Steam and Multimedia.
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-steam.repo
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-multimedia.repo
# RPMFusion.
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y "Development-Tools" "Security-Lab"
# Low level.
dnf install -y kernel-devel kernel-headers acpid dkms strace lsof htop git curl wget vim emacs-nox qbittorrent-nox gcc-c++ ruby nmap libdvdnav libdvdread libbluray p7zip p7zip-plugins zip unzip tftp wireshark wireshark-cli java-1.8.0-openjdk java-1.8.0-openjdk-devel
# Network monitoring tools.
dnf install -y nethogs iftop
# High level.
dnf install -y qt5-qtconfiguration inkscape inkscape-psd krita qbittorrent pavucontrol-qt wireshark-qt steam vulkan vulkan.i686 qt-creator kde-partitionmanger quassel kdenlive simplescreenrecorder filezilla
# Fonts.
dnf install -y liberation-fonts-common dejavu-fonts-common google-noto-fonts-common google-noto-emoji-fonts
# Themes.
dnf install -y adwaita-cursor-theme adwaita-gtk2-theme adwaita-icon-theme gtk-murrine-engine numix-gtk-theme numix-icon-theme numix-icon-theme-circle moka-icon-theme paper-icon-theme tango-icon-theme tango-icon-theme-extras faience-icon-theme
# Adobe Flash.
rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
dnf install -y flash-plugin alsa-plugins-pulseaudio libcurl
# Multimedia.
dnf install -y HandBrake-gui HandBrake-cli makemkv vlc libdvdcss libbluray ffmpeg gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-ugly gstreamer1-plugins-bad gstreamer1-plugins-bad-free gstreamer1-plugins-ugly-free GraphicsMagick
# PlayOnLinux.
dnf install -y playonlinux
 # Discord. (Run as user)
 # git clone https://github.com/RPM-Outpost/discord.git
 # cd discord
 # ./create-package.sh canary
 # # To fix discord-desktop issue.
 # mv /opt/discord-stable /opt/discord-canary
# Autoremove any unneeded dependancies.
dnf autoremove -y
