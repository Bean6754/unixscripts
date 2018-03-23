#!/bin/bash

alias bat='cat /sys/class/power_supply/BAT0/capacity'

while true
do
  clear
  bat
  sleep 5
done
