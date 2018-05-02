#!/bin/bash
#

src=${BASH_SOURCE%/*}

curator --config ${src}/config.yml ${src}/backup.yml

backupsrc=/srv/datas/efk/backup
backupdir=/srv/backs

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# Add New Backup
/srv/scripts/backup-dir.sh "local-elastic" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	rm -rf $backupsrc/*

	echo "Elastic: Ok"
else
    echo "Elastic: Fail"  
    exit 1  
fi