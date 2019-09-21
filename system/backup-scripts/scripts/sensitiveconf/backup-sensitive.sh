#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupdir=/srv/backs
backupsrc=/srv/datas/sensitive
configdir=/opt/poppypop/docker

mkdir -p "$backupsrc"

#find "$configdir" -name "*.env" -not -path "*sample*" -exec cp --parents \{\} "$backupsrc"  \;

rsync -am --include '*.env' --include '*.conf' --include '*.db' --exclude '*sample*' --include='*/' --exclude '*' "$configdir" "$backupsrc"

# Add New Backup
$src/../backup-dir.sh "local-sensitive" "$backupsrc" "$backupdir"

if [ $? -eq 0 ]
then
	echo "Sensitive: Ok"
else
    echo "Sensitive: Fail"  
    exit 1  
fi

rm -rf "$backupsrc"