#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

chmod -R 700 /home/isabella/
chmod -R 700 /home/user2/

chmod 700 /home/isabella/.ssh/
chmod 644 /home/isabella/.ssh/authorized_keys
#chmod 600 /home/isabella/.ssh/id_rsa

chmod 700 /home/user2/.ssh/
chmod 644 /home/user2/.ssh/authorized_keys
#chmod 600 /home/user2/.ssh/id_rsa
