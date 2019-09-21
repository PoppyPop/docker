#!/bin/bash
#

src=${BASH_SOURCE%/*}

username=bkpuser
password=$(cat $src/password.key)
datadir=/srv/datas/mariadb/
conf=/srv/confs/mariadb/my.cnf

backupdir=/srv/backs/mariadb
backupdest=/srv/backs

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# Create the Backup
# export PATH=$PATH:/path/to/xtrabackup
# innobackupex --slave-info --user=$username --password=$password --no-timestamp /path/to/backupdir/db.$now 1>/path/to/backupdir/db.$now.log 2>&1
xtrabackup \
    --defaults-file=$conf \
    --host=10.0.1.10 --port=3306 \
    --user=$username --password=$password \
    --datadir=$datadir --rsync --socket= \
    --backup --target_dir=$backupdir 1> $backupdir/bdd.log 2>&1

# Prepare the Backup
if [ $? -eq 0 ]
then
        xtrabackup --prepare --target_dir=$backupdir 1>> $backupdir/bdd.log 2>&1
else
    echo "Mariadb: Fail"  
    exit 1  
fi

/srv/scripts/backup-dir.sh "local-mariadb" "$backupdir" "$backupdest"

if [ $? -eq 0 ]
then
	rm -rf $backupdir

	echo "Mariadb: Ok"
else
    echo "Mariadb: Fail"  
    exit 1  
fi
