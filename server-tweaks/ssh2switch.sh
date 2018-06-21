#!/bin/bash

read -p 'Enter the switch IP address: ' ip

ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-dss -c aes256-cbc $ip
