#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupsrc=/srv/datas/efk
backupdir=/srv/backs

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

curator --config ${src}/config.yml ${src}/backup.yml

# Add New Backup
$src/../backup-dir.sh "local-elastic" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	echo "Elastic: Ok"
else
    echo "Elastic: Fail"  
    exit 1  
fi