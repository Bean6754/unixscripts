#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi


cd /var/www/log/
mkdir -p rsyslog-backups

# Backup with appending the date and time to the folder
# whilst running the argument to check if there are
# more than 5 folders/files in the directory, if so
# then delete the oldest folder/file.
if [[ $(ls -l /var/www/log/rsyslog-backups/ | wc -l) -ge 6 ]]; then
  pushd /var/www/log/rsyslog-backups/
  rm -rf $(ls -t /var/www/log/rsyslog-backups/ | tail -1)
  popd
  mv rsyslog rsyslog-backups/rsyslog+$(date +"%Y-%m-%d_%H-%M-%S")
  mkdir -p rsyslog
elif [[ $(ls -l /var/www/log/rsyslog-backups/ | wc -l) -le 5 ]]; then
  mv rsyslog rsyslog-backups/rsyslog+$(date +"%Y-%m-%d_%H-%M-%S")
  mkdir -p rsyslog
else
  exit 1
fi
