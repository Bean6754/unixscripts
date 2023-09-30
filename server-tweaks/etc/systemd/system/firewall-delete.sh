[Unit]
Description=Stop the firewall boot-up script.

[Service]
ExecStart=/bin/bash /usr/local/bin/bean6754/firewall-delete.sh
User=root

[Install]
WantedBy=multi-user.target
