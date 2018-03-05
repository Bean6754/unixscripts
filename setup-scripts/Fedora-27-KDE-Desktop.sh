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
dnf install -y qt5-qtconfiguration inkscape inkscape-psd krita qbittorrent pavucontrol-qt wireshark-qt steam vulkan vulkan.i686 qt-creator kde-partitionmanager quassel kdenlive simplescreenrecorder filezilla redshift plasma-applet-redshift-control
# Fonts.
dnf install -y liberation-fonts-common dejavu-fonts-common google-noto-fonts-common google-noto-emoji-fonts
# Themes.
dnf install -y plasma-breeze sddm-breeze sddm-themes numix-icon-theme numix-icon-theme-circle moka-icon-theme paper-icon-theme tango-icon-theme tango-icon-theme-extras faience-icon-theme
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
# VirtualBox.
wget https://www.virtualbox.org/download/oracle_vbox.asc
rpm --import oracle_vbox.asc
wget https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo -O /etc/yum.repos.d/virtualbox.repo
dnf update -y
dnf install -y VirtualBox-5.2
# Extention-pack (run as regular user).
# wget https://download.virtualbox.org/virtualbox/5.2.8/Oracle_VM_VirtualBox_Extension_Pack-5.2.8-121009.vbox-extpack
# Open: Oracle_VM_VirtualBox_Extension_Pack-5.2.8-121009.vbox-extpack
# For me (ckb-next, Corsair K70 RGB driver and manager).
# dnf copr enable johanh/ckb
# dnf install -y ckb-next
dnf autoremove -y
