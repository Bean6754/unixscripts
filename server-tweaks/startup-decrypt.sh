#!/bin/bash

start() {
	PASSWD="password"
	
	vgscan --mknodes
	vgchange -ay
	
	echo -n $PASSWD | cryptsetup luksOpen /dev/mapper/vg01-storage1_crypt storage1_crypt -d -
	echo -n $PASSWD | cryptsetup luksOpen /dev/mapper/vg02-storage2_crypt storage2_crypt -d -
	
	# Make folders (just in case).
	mkdir -p /mnt/storage1
	mkdir -p /mnt/storage2
	
	mount /dev/mapper/storage1_crypt /mnt/storage1
	mount /dev/mapper/storage2_crypt /mnt/storage2
	
	systemctl restart httpd
	systemctl restart nginx
}

stop() {
	umount /mnt/storage1
	umount /mnt/storage2
	
	cryptsetup luksClose storage1_crypt
	cryptsetup luksClose storage2_crypt
	
	lvchange -an -v /dev/vg01/storage1_crypt
	lvchange -an -v /dev/vg02/storage2_crypt
	
	systemctl stop httpd
	systemctl stop nginx
}

case $1 in
	start|stop) "$1" ;;
esac
