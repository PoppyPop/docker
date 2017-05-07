#!/bin/bash
#

src=${BASH_SOURCE%/*}

curator --config ${src}/config.yml ${src}/backup.yml

backupdir=/srv/backs/efk
backupsrc=/srv/datas/efk/backup

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# First: Remove old backups
rm -rf $backupdir/elastic.tar.gz

# Add New Backup
tar -zcf $backupdir/elastic.tar.gz -C $backupsrc .

