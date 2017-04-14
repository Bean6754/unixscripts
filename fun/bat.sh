#!/bin/sh

alias bat='cat /sys/class/power_supply/BAT0/capacity'
for (( ;; ))
do
  sleep 5
  clear
  bat
done
exit 0
