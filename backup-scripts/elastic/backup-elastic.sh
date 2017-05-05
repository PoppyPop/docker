#!/bin/bash
#

src=${BASH_SOURCE%/*}

curator --config ${src}/config.yml ${src}/backup.yml

backupdir=/srv/backs/efk
backupsrc=/srv/datas/efk
now=`date +"%Y-%m-%d_%H-%M"`

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# First: Remove old backups
find $backupdir/ -type f -mtime +30 -delete

# Add New Backup
tar -zcf $backupdir/$now.tar.gz -C $backupsrc .

