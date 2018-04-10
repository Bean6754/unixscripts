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
zypper ref
zypper up -y
zypper dup

# Low-level and development tools.
zypper install -t pattern devel_basis
zypper install -y make cmake git curl wget lsof strace htop vim emacs-nox python2 python3 ruby gcc gcc-c++ lua tcl java-11-openjdk java-11-openjdk-devel qbittorrent-nox

# Networking tools.
zypper in -y wireshark tcpdump

# High-level and multimedia codecs.
wget http://download.opensuse.org/repositories/home:/smarty12:/libraries/openSUSE_Leap_15.0/x86_64/libdvdcss2-1.4.0+git2.2f12236-lp150.2.2.x86_64.rpm
rpm -i libdvdcss2-1.4.0+git2.2f12236-lp150.2.2.x86_64.rpm
rm -rf ibdvdcss2-1.4.0+git2.2f12236-lp150.2.2.x86_64.rpm
zypper install -y libdvdnav4 libdvdread4 ffmpeg lame gstreamer gstreamer-plugins-libav gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly redshift qbittorrent vlc vlc-codec-gstreamer simplescreenrecorder kdenlive firewall-config steam steamtricks steamcmd

# Adobe Flash.
rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
zypper ref
zypper in -y adobe-release-x86_64 flash-plugin

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
