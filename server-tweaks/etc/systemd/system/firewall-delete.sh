#!/bin/bash

/bin/bash /usr/local/bin/bean6754/iptables-stop.sh ; /bin/bash /usr/local/bin/bean6754/delete-sysctl.sh
systemctl disable firewall.service
