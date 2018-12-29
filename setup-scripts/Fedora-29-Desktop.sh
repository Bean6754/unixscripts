#!/bin/bash

## UNCOMPLETE!

# Add RPMFusion.
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Update system.
sudo dnf update -y

# Group packages.
dnf groupinstall -y "Development Tools" "C Development Tools and Libraries" "Security Lab"

sudo dnf install -y chromium vlc vlc-extras wireshark wireshark-cli nmap
sudo usermod -a -G wireshark $USER

# Themes.
sudo dnf install -y gnome-tweaks chrome-gnome-shell arc-theme dmz-cursor-themes papirus-icon-theme

# My setup specific.
sudo dnf install -y solaar
