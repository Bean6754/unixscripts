#!/bin/bash

cryptsetup -v -c aes-xts-plain64 -s 512 -h sha512 -i 4000 --use-urandom -y luksFormat /dev/sda1
cryptsetup -v -c aes-xts-plain64 -s 512 -h sha512 -i 4000 --use-urandom -y luksFormat /dev/sdb1
cryptsetup luksOpen /dev/sda1 storage1_crypt
cryptsetup luksOpen /dev/sdb1 storage2_crypt

mkfs.ext4 -jv /dev/mapper/storage1_crypt -L 'storage1'
mkfs.ext4 -jv /dev/mapper/storage2_crypt -L 'storage2'

mkdir -p /mnt/storage1
mkdir -p /mnt/storage2
mount /dev/mapper/storage1_crypt /mnt/storage1
mount /dev/mapper/storage2_crypt /mnt/storage2

# LVM2 (Don't recommend, not very hot-swappable).
# pvcreate /dev/mapper/storage1_crypt
# pvcreate /dev/mapper/storage2_crypt
# vgcreate storage1_vg /dev/mapper/storage1_crypt
# vgcreate storage2_vg /dev/mapper/storage2_crypt
# lvcreate -l100%FREE -n storage1 storage1_vg
# lvcreate -l100%FREE -n storage2 storage2_vg
# vgscan --mknodes
# vgchange -ay
