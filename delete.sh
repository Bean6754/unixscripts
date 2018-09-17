#!/bin/bash

if [ "$1" = "" ]; then
	echo "delete.sh <file1.txt> <file2.txt> <file3.txt>"
	exit 1
elif [ "$1" != "" ]; then
	for f in $(cat $1 $2 $3); do
		sudo rm -rf "$f"
	done
	# To delete <file1.txt> <file2.txt> <file3.txt>
	# sudo rm -rf "$1" "$2" "$3"
else
	exit 1
fi
