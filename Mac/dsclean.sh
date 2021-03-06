#!/bin/bash

# A recursive '.DS_Store' cleaner.

args=("$@")
curdir="$(pwd)"

if [[ "$args" = "-h" || "$args" = "--help" ]]; then
	echo "dsclean.sh </path/to/directory>"
	exit 1
elif [[ "$args" = "" || "$args" = " " ]]; then
	sudo find "$curdir" -name ".DS_Store" -depth -exec rm {} \;
else
	sudo find "$args" -name ".DS_Store" -depth -exec rm {} \;
fi
