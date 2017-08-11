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
# Negativo17 multimedia: (Needed for p7zip, rar and unrar.)
dnf config-manager --add-repo=http://negativo17.org/repos/fedora-multimedia.repo -y

## Packages.

# Update repositories and any potential packages.
dnf update -y
# Group packages.
dnf groupinstall -y development-tools
# Singular packages.
dnf install -y git wget curl htop nmap ruby gem gcc gcc-c++ python perl java-1.8.0-openjdk java-1.8.0-openjdk-devel vim transmission-cli iftop p7zip rar unrar zip unzip

# Enable firewalld at boot (and start it).
systemctl enable firewalld && systemctl start firewalld
firewall-cmd --runtime-to-permanent
firewalld
echo '#!/bin/sh' > /etc/init.d/firewalld
echo >> /etc/init.d/firewalld
echo 'firewalld' >> /etc/init.d/firewalld
echo >> /etc/init.d/firewalld
echo 'exit 0' >> /etc/init.d/firewalld
chmod +x /etc/init.d/firewalld

exit 0
