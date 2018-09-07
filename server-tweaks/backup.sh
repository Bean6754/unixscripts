#!/bin/bash

shortdate=`date +"%d-%m-%y"`

mkdir -p /mnt/f/backup_$shortdate
rsync -av -P /mnt/e/* /mnt/f/backup_$shortdate/
