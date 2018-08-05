#!/bin/bash

# Functions.
start()
{
	sudo killall httpd
	sudo killall php-fpm
	sudo killall php
	
	sudo httpd
	sudo php-fpm
}

stop()
{
	sudo killall httpd
	sudo killall php-fpm
	sudo killall php
}

# If statements for arguments.
if [[ "$@" == "start" ]]
then
	start
elif [[ "$@" == "stop" ]]
then
	stop
else
	echo "Please enter 'start' or 'stop'."
fi
