#!/bin/bash

# Global variables.
pretty_date=$(date "+%Y-%m-%d_%H-%M-%S")

# Create log-files if missing.
touch /var/log/f2b-banlist.log
touch /var/log/f2b-permaban.log

# Show IPs only more than 3 times occurance and output them to a permaban list.
sort /var/log/f2b-banlist.log | uniq -cd | awk -v limit=3 '$1 > limit{print $2}' >> /var/log/f2b-permaban.log

# Check for any duplicate IPs in the permaban list (this will be common).
cp /var/log/f2b-permaban.log /var/log/f2b-permaban1.log
sort /var/log/f2b-permaban1.log | uniq > /var/log/f2b-permaban.log
rm -f /var/log/f2b-permaban1.log

# Move the current banlist to backup to reduce IP duplication in permaban list when this script is next ran by Crontab.
mv /var/log/f2b-banlist.log /var/log/f2b-banlist_$pretty_date.log
rm -f /var/log/f2b-banlist.log
touch /var/log/f2b-banlist.log

# Permanently ban those IP addresses!
/sbin/iptables -N f2b-permaban
/sbin/iptables -A f2b-permaban -j DROP
cat /var/log/f2b-permaban.log | while read IP; do /sbin/iptables -I f2b-permaban 1 -s $IP -j DROP; done

# Log-rotation (kind of).
## Run the if-statement twice (nested if-statement) as single removal round won't remove additional log files greater than 5 due to new creation on script re-run.
ifHowManyLogs=$(ls /var/log/f2b-banlist_* | wc -l)
if [ $ifHowManyLogs -gt 5 ]; then
  rm -f "$(stat -c '%Y:%n' /var/log/f2b-banlist_* | sort -t: -n | tail -1 | cut -d: -f2-)"
  ifHowManyLogs=$(ls /var/log/f2b-banlist_* | wc -l) # Re-run the variable for the second/nested if-statement.
  #echo First Removal
  if [ $ifHowManyLogs -gt 5 ]; then
    rm -f "$(stat -c '%Y:%n' /var/log/f2b-banlist_* | sort -t: -n | tail -1 | cut -d: -f2-)"
    #echo Second Removal
  fi
else
  echo
  # Continue.
fi
