#!/bin/bash
#

backupdir=/srv/backs
backupsrc=/srv/datas/sensitive
configdir=/home/poppy/git/docker

mkdir -p "$backupsrc"

find "$configdir" -name "*.env" -not -path "*sample*" -exec cp {} "$backupsrc"  \;

# Add New Backup
/srv/scripts/backup-dir.sh "local-sensitive" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	echo "Sensitive: Ok"
else
    echo "Sensitive: Fail"  
    exit 1  
fi

rm -rf "$backupsrc"