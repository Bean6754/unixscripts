#!/bin/bash

if [ "$1" = "" ]; then
	echo "delete.sh <file1.txt> <file2.txt> <file3.txt>"
	exit 1
elif [ "$1" != "" ]; then
	for f in $(cat $1 $2 $3); do
		sudo rm -rf "$f"
	done
else
	exit 1
fi
