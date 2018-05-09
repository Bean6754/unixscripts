#!/bin/bash

# For Ubuntu 18.04.

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
apt update -y
apt upgrade -y
apt dist-upgrade -y

# Low-Level.
apt install -y aptitude wget curl git strace lsof htop vim emacs-nox zip unzip p7zip-full build-essential default-jdk tshark tcpdump nmap transmission-cli hddtemp lm-sensors neofetch scanmem tmux ufw net-tools ssh
