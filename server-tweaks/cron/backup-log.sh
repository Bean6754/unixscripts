#!/bin/bash

## README.
# For cron support:
# Add a supersudo group and a NOPASSWD option to sudo.
#
# Otherwise the script will fail because sudo
# will wait for a password request and stall.
#
# For example:
# groupadd supersudo
# usermod -a -G supersudo user
# Add to /etc/sudoers:
# %supersudo ALL=(ALL:ALL) NOPASSWD:ALL


# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# Variables.
datevar=$(date +"%Y-%m-%d_%H-%M-%S")
hostnamevar=$(hostname)
host1="172.16.1.21" # Host 1
host2="172.16.1.22" # Host 2.
host3="172.16.1.23" # Host 3.
host1_name="nas-vm-host1" # Host 1.
host2_name="nas-vm-host2" # Host 2.
host3_name="nas-vm-host3" # Host 3.

cd /share/
# pre-make directories if needed for rsync.
## Localhost.
mkdir -p log-backups/$datevar/$hostnamevar/var/log
## Host 1.
mkdir -p log-backups/$datevar/$host1_name/var/log
## Host 2.
mkdir -p log-backups/$datevar/$host2_name/var/log
## Host 3.
mkdir -p log-backups/$datevar/$host3_name/var/log

# Backup with appending the date and time to the folder
# whilst running the argument to check if there are
# more than 5 folders/files in the directory, if so
# then delete the oldest folder/file.
if [[ $(ls -l /share/log-backups | wc -l) -ge 6 ]]; then
  pushd /share/log-backups
  rm -rf $(ls -t /share/log-backups | tail -1)
  popd

  ## Localhost.
  # /var/log
  rsync -avP /var/log/* log-backups/$datevar/$hostnamevar/var/log
  # Fix /var/log from getting too large.
  rm -rf /var/log/*

  ## Host 1.
  # /var/log
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/var/log/* log-backups/$datevar/$host1_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host1 'sudo rm -rf /var/log/*'

  ## Host 2.
  # /var/log
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/var/log/* log-backups/$datevar/$host2_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host2 'sudo rm -rf /var/log/*'

  ## Host 3.
  # /var/log
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/var/log/* log-backups/$datevar/$host3_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host3 'sudo rm -rf /var/log/*'


  # Apply permissions.
  bash /share/permissions.sh
elif [[ $(ls -l /share/log-backups | wc -l) -le 5 ]]; then

  ## Localhost.
  # /var/log
  rsync -avP /var/log/* log-backups/$datevar/$hostnamevar/var/log
  # Fix /var/log from getting too large.
  rm -rf /var/log/*

  ## Host 1.
  # /var/log
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/var/log/* log-backups/$datevar/$host1_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host1 'sudo rm -rf /var/log/*'

  ## Host 2.
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/var/log/* log-backups/$datevar/$host2_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host2 'sudo rm -rf /var/log/*'

  ## Host 3.
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/var/log/* log-backups/$datevar/$host3_name/var/log
  # Fix /var/log from getting too large.
  ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no isabella@$host3 'sudo rm -rf /var/log/*'


  # Apply permissions.
  bash /share/permissions.sh
else
  exit 1
fi
