#!/bin/sh

## Make sure free, non-free and contrib are enabled.

dpkg --add-architecture i386
apt update
apt upgrade -y
apt dist-upgrade -y

# Low-level
apt install -y aptitude git curl wget vim sudo fakeroot p7zip-full zip unzip strace lsof htop nmap build-essential tshark intel-microcode open-cobol lua5.3 gfortran-7
# High-level
apt install -y wireshark qbittorrent gimp vlc libdvdnav4 libdvdread4 libdvdcss2 libbluray2

exit 0
