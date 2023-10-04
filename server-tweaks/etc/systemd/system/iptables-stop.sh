#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# iptables reset.

# Delete current ruleset.
rm -rf /etc/iptables/rules.*

# Flush all rules.
/sbin/iptables -Z
/sbin/iptables -F
/sbin/iptables -X
# Default ruleset.
/sbin/iptables -P INPUT ACCEPT
/sbin/iptables -P FORWARD ACCEPT
/sbin/iptables -P OUTPUT ACCEPT
# Default tableset.
/sbin/iptables -t nat -F
/sbin/iptables -t mangle -F
# Re-flush all rules.
/sbin/iptables -Z
/sbin/iptables -F
/sbin/iptables -X
