#!/bin/bash

/bin/bash /usr/local/bin/bean6754/iptables.sh ; /bin/bash /usr/local/bin/bean6754/copy-sysctl.sh
systemctl enable firewall.service
