#!/bin/bash

# Functions.
start()
{
	sudo networksetup -setsocksfirewallproxy Wi-Fi 127.0.0.1 9050
	# sudo networksetup -setsocksfirewallproxy Ethernet 127.0.0.1 9050
	sudo networksetup -setsocksfirewallproxystate Wi-Fi on
	# sudo networksetup -setsocksfirewallproxystate Ethernet on
	echo "SOCKS proxy enabled."
	killall tor
	tor&
	echo "Started tor."
}

stop()
{
	sudo networksetup -setsocksfirewallproxystate Wi-Fi off
	# sudo networksetup -setsocksfirewallproxystate Ethernet off
	echo "SOCKS proxy disabled."
	killall tor
	echo "Killed tor."
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
