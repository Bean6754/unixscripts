#!/bin/bash

cupsctl --remote-admin

# 'systemctl restart cups' hangs.. :/
systemctl stop cups
systemctl start cups
systemctl enable cups
