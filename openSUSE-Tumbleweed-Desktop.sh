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

# Install development tools.
zypper install -t pattern devel_basis
zypper install -y make cmake git curl wget vim emacs-nox python2 python3 ruby gcc gcc-c++ lua tcl java-1_8_0-openjdk java-1_8_0-openjdk-devel

# Networking tools.
zypper in -y wireshark tcpdump

# Multimedia codecs.
echo Type 'a' then press the enter key
zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss
zypper ref
zypper install -y libdvdnav4 libdvdread4 libdvdcss2 ffmpeg lame gstreamer gstreamer-plugins-libav gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly vlc vlc-codec-gstreamer simplescreenrecorder kdenlive firewall-config

# Adobe Flash.
zypper ar --check --refresh http://linuxdownload.adobe.com/linux/x86_64/ adobe
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
zypper ref
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
zypper install adobe-release-x86_64 flash-plugin

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
