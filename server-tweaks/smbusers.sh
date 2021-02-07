#!/bin/bash

user1="Isabella"
cmd=$(sudo pdbedit -L -v | grep "Full Name:")

if [[ $cmd == *"$user1"* ]]
then
    echo User $user1 exists
    exit 1
elif [[ $cmd != *"$user1"* ]]
then
    # Create samba user.
    sudo smbpasswd -a isabella
    # Delete samba user.
    # sudo smbpasswd -x isabella
else
    echo Error
    exit 1
fi
