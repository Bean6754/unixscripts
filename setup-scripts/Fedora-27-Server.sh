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

# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y "Development Tools" "C Development Tools and Libraries"
# Low level.
dnf install -y kernel-devel kernel-headers acpid dkms strace lsof htop git curl wget vim emacs-nox tmux transmission-cli gcc-c++ ruby nmap p7zip p7zip-plugins zip unzip tftp wireshark-cli java-1.8.0-openjdk java-1.8.0-openjdk-devel neofetch figlet toilet cowsay
# Network monitoring tools.
dnf install -y nethogs iftop
# Security.
dnf install -y chkrootkit clamav clamav-update
freshclam
# Server specific.
dnf install -y nginx
# Autoremove any unneeded dependancies.
dnf autoremove -y
