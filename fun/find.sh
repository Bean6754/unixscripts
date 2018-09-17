#!/bin/bash

DIR=$1
STRING=$2

if [ "$1" = "" ] || [ "$2" = "" ]; then
	echo "find.sh <directory> <string>"
	exit 1
elif [ "$1" != "" ] && [ "$2" != "" ]; then
	find $DIR -iname "*$STRING*" 2>/dev/null
else
	exit 1
fi
