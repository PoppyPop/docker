#!/bin/bash
#

backupdir=/srv/backs
backupsrc=/srv/datas/web

# Add New Backup
/srv/scripts/backup-dir.sh "local-web" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	echo "Web: Ok"
else
    echo "Web: Fail"  
    exit 1  
fi