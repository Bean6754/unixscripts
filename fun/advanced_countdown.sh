#!/bin/bash

while true
do
	clear
	echo ls -aGl
	echo
	
	secs=$((60))
	while [ $secs -gt 0 ]
	do
		echo -ne "Waiting $secs second(s). \033[0K\r"
		sleep 1
		: $((secs--))
	done
done
