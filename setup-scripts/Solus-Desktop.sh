#!/bin/bash

# up = upgrade
# it = install

eopkg up -y
eopkg it -y -c system.devel
eopkg it -y emacs vim neofetch
# nvidia-glx-driver-current
eopkg it -y steam virtualbox-current
