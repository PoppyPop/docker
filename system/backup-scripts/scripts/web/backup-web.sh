#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupdir=/srv/backs
backupsrc=/srv/datas/web

# Add New Backup
sudo $src/../backup-dir.sh "local-web" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	echo "Web: Ok"
else
    echo "Web: Fail"  
    exit 1  
fi