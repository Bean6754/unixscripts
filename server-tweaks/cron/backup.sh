#!/bin/bash

# Make sure only root can run our script.
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi


# Variables.
shortdate=$(date +"%d-%m-%y_%H:%M")
dir="/mnt/storage2/backups"
folder_count=$(ls $dir | wc -l)

IFS= read -r -d $'\0' line < <(find "$dir" -maxdepth 1 -printf '%T@ %p\0' 2>/dev/null | sort -z -n)
file="${line#* }"


# Code.
if [[ $folder_count -gt 3 ]] # >
then
  #echo Greater than 3
  rm -rf $file
  mkdir -p $dir/backup_$shortdate
  rsync -avP /mnt/storage1/* $dir/backup_$shortdate
elif [[ $folder_count -le 3 ]] # <=
then
  #echo Less than or equal to 3
  mkdir -p $dir/backup_$shortdate
  rsync -avP /mnt/storage1/* $dir/backup_$shortdate
else
  echo Error
  exit 1
fi
