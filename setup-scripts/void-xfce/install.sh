#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

cp pkg_term.txt pkg_term2.txt
sort pkg_term2.txt > pkg_term.txt
rm -f pkg_term2.txt

cp pkg_get_iplayer.txt pkg_get_iplayer2.txt
sort pkg_get_iplayer2.txt > pkg_get_iplayer.txt
rm -f pkg_get_iplayer2.txt

cp pkg_kvm.txt pkg_kvm2.txt
sort pkg_kvm2.txt > pkg_kvm.txt
rm -f pkg_kvm2.txt

cp pkg_desktop.txt pkg_desktop2.txt
sort pkg_desktop2.txt > pkg_desktop.txt
rm -f pkg_desktop2.txt

cp pkg_hotspot.txt pkg_hotspot2.txt
sort pkg_hotspot2.txt > pkg_hotspot.txt
rm -f pkg_hotspot2.txt

cp pkg_fonts.txt pkg_fonts2.txt
sort pkg_fonts2.txt > pkg_fonts.txt
rm -f pkg_fonts2.txt

cp pkg_steam.txt pkg_steam2.txt
sort pkg_steam2.txt > pkg_steam.txt
rm -f pkg_steam2.txt

# Install 'pkg_term.txt' first to enable repos.
# Use '/usr/bin/cat' to not cause issues with my 'batcat' installation located at '/usr/local/bin/batcat'.
xbps-install -S
xbps-install $(/usr/bin/cat pkg_term.txt)
xbps-install -S

xbps-install $(/usr/bin/cat pkg_get_iplayer.txt pkg_kvm.txt pkg_desktop.txt pkg_hotspot.txt pkg_fonts.txt pkg_steam.txt)

# Update font-cache.
fc-cache -f
