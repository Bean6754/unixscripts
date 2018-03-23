#!/bin/bash

while true
do
  clear
	filesize=$(stat -c%s /mnt/Win10_1703_English_x64.iso)
	expr "$filesize" / 1000000 && echo MB
	echo
	expr "$filesize" / 1000000000 && echo GB
	# wc -c /mnt/Win10_1703_English_x64.iso | awk '{print $1}'
	sleep 6
done
