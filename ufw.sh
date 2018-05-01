#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Enable then start service at boot.
systemctl enable ufw
systemctl start ufw

# Enable firewall.
ufw enable

# SSH.
ufw allow 22/tcp
# HTTP.
ufw allow 80/tcp
# HTTPS.
ufw allow 443/tcp

# Reload firewall.
ufw reload
