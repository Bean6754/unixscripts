#!/bin/bash

## Example list (8): 
# lirquen.dcc.uchile.cl
# ip18.ip-5-196-38.eu
# mirror.koddos.net
# ns327660.ip-37-187-111.eu
# sledjhamr.org
# ftp.rrze.uni-erlangen.de
# 44-112-203-185.place5.ungleich.ch
# mirror01.core.dc1.nl.vpgrp.io

clear
echo INFO: This program will ping the URL x amount of times with 9 bytes of data.
echo INFO: This program will sometimes repeat URLs.
echo
read -p 'How many mirrors do you want? ' ui
echo

for ((i=1; i<=ui; i++)); do
        ping -s1 -c1 deb.devuan.org | grep "9 bytes from"|awk '{print $4}'
done
