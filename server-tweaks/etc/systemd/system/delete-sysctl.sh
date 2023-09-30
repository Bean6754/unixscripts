#!/bin/bash

rm -f /etc/sysctl.d/firewall.conf
sysctl --system
