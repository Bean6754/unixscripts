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

## Repositories.

# RPM Fusion:   (Optional, not needed.)
# dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Packages.

# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y development-tools
# Singular packages.
dnf install -y git wget curl htop nmap ruby gem gcc gcc-c++ python perl java-1.8.0-openjdk java-1.8.0-openjdk-devel vim transmission-cli

exit 0
