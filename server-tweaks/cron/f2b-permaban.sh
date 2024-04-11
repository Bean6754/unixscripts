#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." 1>&2
  exit 1
fi

# Log entries with more than 5 occurances to tmp-file then remove duplicate entries to new log-file.
uniq -c /var/log/f2b-banlist.log | awk '$1 >= 5 { print $2,$3 }' > /tmp/f2b.log
sort /tmp/f2b.log | uniq > /var/log/f2b-permabanlist.log
rm -f /tmp/f2b.log

# Delete chain (to prevent duplicate IPs) then create it as new.
/sbin/iptables -F f2b-permaban
/sbin/iptables -Z f2b-permaban
/sbin/iptables -X f2b-permaban
/sbin/iptables -N f2b-permaban

badip=/var/log/f2b-permabanlist.log
egrep -v "^#|^$" $badip | while IFS= read -r ip
do
  # Add IPs from the new log-file to the new chain.
  /sbin/iptables -I f2b-permaban 1 -s $ip -j DROP
done < "$badip"
