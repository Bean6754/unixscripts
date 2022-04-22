#!/bin/bash

## Dependencies: apt (auto-installed), s-nail and perl (auto-installed).

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# Variables.
datevar=$(date +"%Y-%m-%d_%H-%M-%S")
hostnamevar=$(hostname)
mkdir -p /var/log/mail-update
logpath="/var/log/mail-update"

# Functions.
update_func() {
  echo "-------- apt-get update --------" > $logpath/update_$datevar.txt2
  update=$(apt-get update >> $logpath/update_$datevar.txt2)

  echo "-------- apt-get full-upgrade --------" >> $logpath/update_$datevar.txt2
  full_upgrade=$(apt-get full-upgrade -y --allow-downgrades --allow-remove-essential --allow-change-held-packages >> $logpath/update_$datevar.txt2)

  echo "-------- update complete --------" >> $logpath/update_$datevar.txt2

  # Convert UNIX line endings to DOS line to fix mail output.
  perl -p -e 's/\n/\r\n/' < $logpath/update_$datevar.txt2 > $logpath/update_$datevar.txt
}

mail_func() {
  (echo "Please find attached the daily update output for $hostnamevar at $datevar:" ; echo "" ; echo "" ; cat $logpath/update_$datevar.txt) | s-nail -v -s "Server Daily Update for $hostnamevar at $datevar" -a "$logpath/update_$datevar.txt" -S mta="smtp://mydomain.net:25" -r "$hostnamevar@mydomain.net" -c "cc1@example.org" -c "cc2@example.org" email@example.org
  rm -rf $logpath/update_$datevar.txt2
}

if [[ $(ls -l /var/log/mail-update/ | wc -l) -ge 36 ]]; then
  pushd /var/log/mail-update/
  rm -rf $(ls -t /var/log/mail-update/ | tail -1)
  popd
  update_func
  mail_func
elif [[ $(ls -l /var/log/mail-update/ | wc -l) -le 35 ]]; then
  update_func
  mail_func
else
  exit 1
fi
