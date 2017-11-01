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

# Install development tools.
zypper install -y make cmake git curl wget vim python2 python3 ruby gcc gcc-c++ lua tcl

# Networking tools.
# zypper install -y 

# Multimedia codecs.
echo Type 'a' then press the enter key
zypper ar -f http://opensuse-guide.org/repo/openSUSE_Tumbleweed/ libdvdcss
zypper ref
zypper install -y libdvdcss2 ffmpeg lame gstreamer-plugins-libav gstreamer-plugins-bad gstreamer-plugins-ugly gstreamer-plugins-ugly-orig-addon vlc vlc-codecs flash-player flash-player-ppapi libxine2 libxine2-codecs

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch

exit 0
