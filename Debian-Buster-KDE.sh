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

## Make sure free, non-free and contrib are enabled.
dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y

# Low-level
apt install -y aptitude git curl wget vim sudo fakeroot p7zip-full zip unzip strace lsof htop nmap build-essential tshark intel-microcode open-cobol lua5.3 gfortran-7
# High-level
apt install -y wireshark qbittorrent gimp vlc libdvdnav4 libdvdread4 libdvdcss2 libbluray2
dpkg-reconfigure libdvd-pkg
apt purge -y openjdk*
apt autoremove -y
apt install -y openjdk-9-jdk

exit 0
