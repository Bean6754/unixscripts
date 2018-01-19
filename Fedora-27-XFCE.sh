#!/bin/sh

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
# negativo17 Steam repo.
dnf config-manager --add-repo=https://negativo17.org/repos/fedora-steam.repo
# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y "Development-Tools" "Security-Lab"
# Low level.
dnf install -y kernel-devel kernel-headers acpid dkms strace lsof htop git curl wget vim transmission-cli gcc-c++ ruby nmap libdvdnav libdvdread libbluray p7zip p7zip-plugins zip unzip wireshark wireshark-cli
# High level.
dnf install -y gimp transmission pavucontrol wireshark-gtk steam
# Adobe Flash.
rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
dnf install flash-plugin alsa-plugins-pulseaudio libcurl

exit 0