#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Update system.
zypper ref
zypper up -y --auto-agree-with-licenses
zypper dup -y --auto-agree-with-licenses

# Low-level and development tools.
zypper install -t pattern devel_basis
zypper install -y lsb-release make cmake git curl wget lsof strace htop vim emacs-nox python2 python3 ruby gcc gcc-c++ lua tcl java-11-openjdk java-11-openjdk-devel transmission

# Networking tools.
zypper in -y wireshark tcpdump nmap ufw whois

# High-level, multimedia codecs and fonts. FFMPEG AND gstreamer-plugins-libav ARE BROKEN!! :'(
zypper in -y libdvdnav4 libdvdread4 lame gstreamer gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly redshift transmission-gtk mpv simplescreenrecorder kdenlive firewall-config
zypper in -y discord steam steamtricks steamcmd gparted gnome-disk-utility noto-coloremoji-fonts noto-emoji-fonts pavucontrol youtube-dl

# VirtualBox.
zypper in -y virtualbox gnome-boxes
usermod -a -G vboxusers $USER

# Google Chrome.
# zypper in -y lsb-release
# rpm ivh https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# Adobe Flash.
# rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
# rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
# zypper ref
# zypper in -y adobe-release-x86_64 flash-plugin

# Skype.
# rpm -ivh https://go.skype.com/skypeforlinux-64.rpm

# Install neofetch and run it.
git clone https://github.com/dylanaraps/neofetch.git
cd neofetch
make install
cd ..
rm -rf neofetch
clear
neofetch
