#!/bin/bash

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

clear
echo Please make sure that you are directly logged in as root!
echo

read -p 'New username: ' newname
read -p 'Old username' oldname

usermod -l $newname $oldname
usermod -m -d /home/$newname $newname

clear
echo Please enter a new password for $newname
passwd $newname
