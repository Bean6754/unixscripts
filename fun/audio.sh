#!/bin/sh

clear
cat /dev/urandom | padsp tee /dev/audio > /dev/null
exit 0
