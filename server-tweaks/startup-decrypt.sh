#!/bin/bash

start() {
	PASSWD="password"
	
	echo -n $PASSWD | cryptsetup luksOpen /dev/mapper/storage1_darknet--server-lvol0 storage1_crypt -d -
	echo -n $PASSWD | cryptsetup luksOpen /dev/mapper/storage2_darknet--server-lvol0 storage2_crypt -d -
	
	mount /dev/mapper/storage1_crypt /mnt/storage1
	mount /dev/mapper/storage2_crypt /mnt/storage2
	
	systemctl start httpd
}

stop() {
	umount /mnt/storage1
	umount /mnt/storage2
	
	cryptsetup luksClose storage1_crypt
	cryptsetup luksClose storage2_crypt
	
	systemctl stop httpd
}

case $1 in
	start|stop) "$1" ;;
esac
