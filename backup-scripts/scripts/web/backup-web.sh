#!/bin/bash
#

backupdir=/srv/backs/web
backupsrc=/srv/datas/web
now=`date +"%Y-%m-%d_%H-%M"`

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# First: Remove old backups
find $backupdir/ -type f -mtime +7 -delete

# Add New Backup
tar -zcf $backupdir/$now.tar.gz -C $backupsrc .
       
