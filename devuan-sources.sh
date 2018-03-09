#!/bin/bash

clear
echo INFO: This program will ping the URL x amount of times with 9 bytes of data.
read -p 'How mirrors do you want? ' ui
echo

for ((i=1; i<=ui; i++)); do
        ping -s1 -c1 deb.devuan.org | grep "9 bytes from"|awk '{print $4}'
done
