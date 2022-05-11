#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# Variables.
datevar=$(date +"%Y-%m-%d_%H-%M-%S")
hostnamevar=$(hostname)
host1="172.16.1.21" # Host 1.
host2="172.16.1.22" # Host 2.
host3="172.16.1.23" # Host 3.
host1_name="nas-vm-host1" # Host 1.
host2_name="nas-vm-host2" # Host 2.
host3_name="nas-vm-host3" # Host 3.

cd /share/
# pre-make directories if needed for rsync.
## Localhost.
mkdir -p config-backups/$datevar/$hostnamevar/etc
mkdir -p config-backups/$datevar/$hostnamevar/home
mkdir -p config-backups/$datevar/$hostnamevar/usr/local/bin
mkdir -p config-backups/$datevar/$hostnamevar/var/www
## Host 1.
mkdir -p config-backups/$datevar/$host1_name/etc
mkdir -p config-backups/$datevar/$host1_name/home
mkdir -p config-backups/$datevar/$host1_name/usr/local/bin
## Host 2.
mkdir -p config-backups/$datevar/$host2_name/etc
mkdir -p config-backups/$datevar/$host2_name/home
mkdir -p config-backups/$datevar/$host2_name/usr/local/bin
## Host 3.
mkdir -p config-backups/$datevar/$host3_name/etc
mkdir -p config-backups/$datevar/$host3_name/home
mkdir -p config-backups/$datevar/$host3_name/usr/local/bin

# Backup with appending the date and time to the folder
# whilst running the argument to check if there are
# more than 5 folders/files in the directory, if so
# then delete the oldest folder/file.
if [[ $(ls -l /share/config-backups | wc -l) -ge 21 ]]; then
  pushd /share/config-backups
  rm -rf $(ls -t /share/config-backups | tail -1)
  popd

  ## Localhost.
  # /etc
  rsync -avP /etc/* config-backups/$datevar/$hostnamevar/etc
  # /home
  rsync -avP /home/* config-backups/$datevar/$hostnamevar/home
  # /usr/local/bin
  rsync -avP /usr/local/bin/* config-backups/$datevar/$hostnamevar/usr/local/bin
  # /var/www
  rsync -avP /var/www/* config-backups/$datevar/$hostnamevar/var/www

  ## Host 1.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/etc/* config-backups/$datevar/$host1_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/home/* config-backups/$datevar/$host1_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/usr/local/bin/* config-backups/$datevar/$host1_name/usr/local/bin

  ## Host 2.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/etc/* config-backups/$datevar/$host2_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/home/* config-backups/$datevar/$host2_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/usr/local/bin/* config-backups/$datevar/$host2_name/usr/local/bin

  ## Host 3.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/etc/* config-backups/$datevar/$host3_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/home/* config-backups/$datevar/$host3_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/usr/local/bin/* config-backups/$datevar/$host3_name/usr/local/bin


  # Reload the nginx process to allow nginx to write to the .log files again.
  kill -USR1 $(cat /var/run/nginx.pid)
  # Apply permissions.
  bash /share/permissions.sh
elif [[ $(ls -l /share/config-backups | wc -l) -le 20 ]]; then

  ## Localhost.
  # /etc
  rsync -avP /etc/* config-backups/$datevar/$hostnamevar/etc
  # /home
  rsync -avP /home/* config-backups/$datevar/$hostnamevar/home
  # /usr/local/bin
  rsync -avP /usr/local/bin/* config-backups/$datevar/$hostnamevar/usr/local/bin
  # /var/www
  rsync -avP /var/www/* config-backups/$datevar/$hostnamevar/var/www

  ## Host 1.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/etc/* config-backups/$datevar/$host1_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/home/* config-backups/$datevar/$host1_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host1:/usr/local/bin/* config-backups/$datevar/$host1_name/usr/local/bin

  ## Host 2.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/etc/* config-backups/$datevar/$host2_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/home/* config-backups/$datevar/$host2_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host2:/usr/local/bin/* config-backups/$datevar/$host2_name/usr/local/bin

  ## Host 3.
  # /etc
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/etc/* config-backups/$datevar/$host3_name/etc
  # /home
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/home/* config-backups/$datevar/$host3_name/home
  # /usr/local/bin
  rsync -avP -e "ssh -i /root/.ssh/sshkey-nopass -o StrictHostKeyChecking=no" --rsync-path="sudo rsync" isabella@$host3:/usr/local/bin/* config-backups/$datevar/$host3_name/usr/local/bin


  # Reload the nginx process to allow nginx to write to the .log files again.
  kill -USR1 $(cat /var/run/nginx.pid)
  # Apply permissions.
  bash /share/permissions.sh
else
  exit 1
fi
