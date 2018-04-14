#!/bin/ksh

# For use on OpenBSD 6.3.

# For partitioning info: https://www.bsdnow.tv/tutorials/fde

# Set pkg_add mirror.
echo 'https://anorien.csc.warwick.ac.uk/pub/OpenBSD' > /etc/installurl

# Update system.
pkg_add -Uu

# Get all firmware.
fw_update -a

# Install packages.
# Low-level.
pkg_add -v curl-7.59.0 emacs-25.3p0-no_x11 git-2.16.2 htop-2.1.0 rsync-3.1.3 python-2.7.14p1 python-3.6.4p0 p7zip-16.02p3 7zip-rar-16.02p1 unrar-5.50v1 unzip-6.0p11 vim-8.0.1589-no_x11 zip-3.0p0 transmission-2.93 tshark-2.4.5

# High-level.
pkg_add -v dmenu-4.7 feh-2.23.1 firefox-59.0.2 firefox-i18n-en-GB-59.0.2 i3-4.14.1p1 i3lock-2.10 i3status-2.11p6 rofi-1.5.0p0 rxvt-unicode-9.22p5 transmission-gtk-2.93 wireshark-gtk-2.4.5

# Setup 'python' to python3.6.
ln -sf /usr/local/bin/python3.6 /usr/local/bin/python
ln -sf /usr/local/bin/python2.7-2to3 /usr/local/bin/2to3
ln -sf /usr/local/bin/python3.6-config /usr/local/bin/python-config
ln -sf /usr/local/bin/pydoc3.6  /usr/local/bin/pydoc

# Setup ufetch.
curl https://raw.githubusercontent.com/jschx/ufetch/master/ufetch-openbsd -o /usr/local/bin/ufetch
chmod +x /usr/local/bin/ufetch
