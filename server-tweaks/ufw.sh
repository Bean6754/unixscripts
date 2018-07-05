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

# Default rules.
ufw default deny incoming
ufw default allow outgoing

# SSH.
ufw allow 22/tcp
# HTTP.
ufw allow 80/tcp
ufw allow 8080/tcp
# HTTPS.
ufw allow 443/tcp
# Samba.
ufw allow 139/tcp
ufw allow 445/tcp
ufw allow 137/udp
ufw allow 138/udp
# qBittorrent-nox daemon/web interface. (Edit: '~/.config/qBittorrent/qBittorrent.conf'.)
ufw allow 8081/tcp
# qBittorrent proxy port. (Edit: '~/.config/qBittorrent/qBittorrent.conf'.)
ufw allow 8082/tcp

# Reload firewall.
ufw reload
