#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Enable then start service at boot.
systemctl enable -- now ufw.service
#update-rc.d ufw defaults
#service ufw start

# Reset UFW.
ufw reset

# Enable firewall.
ufw enable

# Default rules.
ufw default deny incoming
ufw default allow outgoing

# SSH.
ufw limit 22/tcp
# HTTP.
ufw limit 80/tcp
ufw limit 8080/tcp
# HTTPS.
ufw limit 443/tcp
# Samba.
ufw limit 139/tcp
ufw limit 445/tcp
ufw limit 137/udp
ufw limit 138/udp
# Transmission daemon/web interface.
ufw limit 9091/tcp

# Disable ICMP.
sed -i '/ufw-before-input.*icmp/s/ACCEPT/DROP/g' /etc/ufw/before.rules

# Reload firewall.
ufw reload
