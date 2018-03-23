#!/bin/bash

start() {
	PASSWD="password"
	
	echo -n $PASSWD | cryptsetup luksOpen /dev/sda1 storage1_crypt -d -
	echo -n $PASSWD | cryptsetup luksOpen /dev/sdb1 storage2_crypt -d -
	
	vgscan --mknodes
	vgchange -ay
	
	mount /dev/storage1_vg/storage1 /mnt/storage1
	mount /dev/storage2_vg/storage2 /mnt/storage2
	
	service nginx start
}

stop() {
	umount /mnt/storage1
	umount /mnt/storage2
	
	lvchange -an -v /dev/storage1_vg/storage1
	lvchange -an -v /dev/storage2_vg/storage2
	
	cryptsetup luksClose storage1_crypt
	cryptsetup luksClose storage2_crypt
	
	service nginx stop
}

case $1 in
	start|stop) "$1" ;;
esac
