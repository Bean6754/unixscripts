#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Repos.
# Negativo17 Steam and multimedia.
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-steam.repo
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-multimedia.repo
# RPMFusion.
dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"
# Low level.
dnf install -y kernel-devel kernel-headers acpid dkms strace lsof htop git curl wget vim emacs-nox tmux deluge-console deluge-daemon gcc-c++ ruby nmap p7zip p7zip-plugins zip unzip tftp wireshark-cli java-1.8.0-openjdk java-1.8.0-openjdk-devel neofetch figlet toilet cowsay cmatrix
# Network monitoring tools.
dnf install -y nethogs iftop
# Security.
dnf install -y chkrootkit clamav clamav-update
freshclam
# High level.
# KDE: dnf install -y setroubleshoot qt5ct qt5-qtconfiguration libreoffice libreoffice-langpack-en gimp inkscape inkscape-psd krita transmission-qt pavucontrol-qt wireshark-qt steam vulkan vulkan.i686 qt-creator kde-partitionmanager quassel kdenlive simplescreenrecorder filezilla redshift plasma-applet-redshift-control
# GNOME: dnf install -y setroubleshoot chromium kdenlive libreoffice libreoffice-langpack-en gnome-tweak-tool gimp transmission pavucontrol wireshark-gtk steam vulkan vulkan.i686 gnome-builder geany glade gparted guvcview polari pitivi simplescreenrecorder filezilla redshift redshift-gtk conky conky-manager
# LXQt: dnf install -y setroubleshoot chromium libreoffice libreoffice-langpack-en gimp transmission-qt wireshark-qt steam vulkan vulkan.i686 qt-creator kde-partitionmanager guvcview quassel simplescreenrecorder filezilla redshift conky conky-manager
dnf install -y setroubleshoot libreoffice libreoffice-langpack-en gimp deluge deluge-gtk pavucontrol wireshark-gtk steam vulkan vulkan.i686 geany glade gparted baobab guvcview kdenlive simplescreenrecorder filezilla redshift redshift-gtk conky conky-manager wmctrl
setsebool -P selinuxuser_execheap 1

# Fonts.
dnf install -y liberation-fonts-common dejavu-fonts-common google-noto-fonts-common google-noto-emoji-fonts google-noto-mono-fonts google-noto-cjk-fonts-common google-noto-mono-fonts google-noto-sans-fonts google-noto-serif-fonts
# Themes.
# KDE/LXQt: dnf install -y plasma-breeze sddm-breeze sddm-themes
dnf install -y adwaita-cursor-theme adwaita-gtk2-theme adwaita-icon-theme gtk-murrine-engine numix-gtk-theme numix-icon-theme numix-icon-theme-circle paper-icon-theme tango-icon-theme tango-icon-theme-extras faience-icon-theme arc-theme oxygen-cursor-themes f26-backgrounds-extras-gnome
# GNOME: dnf install -y adwaita-cursor-theme adwaita-icon-theme arc-theme paper-icon-theme oxygen-cursor-themes f26-backgrounds-extras-gnome
# Multimedia.
dnf install -y HandBrake-gui HandBrake-cli makemkv vlc libdvdnav libdvdread libdvdcss libbluray ffmpeg gstreamer1-plugins-base gstreamer1-plugins-good gstreamer1-plugins-bad gstreamer1-plugins-ugly gstreamer1-plugins-bad-free gstreamer1-plugins-ugly-free GraphicsMagick
# PlayOnLinux.
dnf install -y playonlinux
# Discord (thanks RPMFusion!)
dnf install -y discord
 # Discord. (Run as user)
 # git clone https://github.com/RPM-Outpost/discord.git
 # cd discord
 # ./create-package.sh canary
 # # To fix discord-desktop issue.
 # mv /opt/discord-stable /opt/discord-canary
# Autoremove any unneeded dependancies.
# VirtualBox and qt-virt-manager.
dnf install -y VirtualBox gnome-boxes virt-manager libvirt-daemon-config-network
# Install VirtualBox extention pack.
curl -LO https://download.virtualbox.org/virtualbox/5.2.8/Oracle_VM_VirtualBox_Extension_Pack-5.2.8.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-5.2.8.vbox-extpack
dnf autoremove -y

# curl https://raw.githubusercontent.com/Bean6754/home/master/.vimrc -o ~/.vimrc
# curl https://raw.githubusercontent.com/Bean6754/home/master/.emacs -o ~/.vimrc
