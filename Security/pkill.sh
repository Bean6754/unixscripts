#!/bin/sh
# WARNING: This script will kill most processes on the system.
# It is best run as root, but it also works in userland.

: '
Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi '

var=2
while true
do
  var=$(( $var + 1 ))
  pkill $var
done
