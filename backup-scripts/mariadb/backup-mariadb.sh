#!/bin/bash
#

username=bkpuser
password=6Vxf6JLD2m4t

now=`date +"%Y-%m-%d_%H-%M"`
backupdir=/srv/backs/mariadb

# Test Folder
if [ ! -d "$backupdir" ]; then
  mkdir -p $backupdir
fi

# First: Remove old backups
find $backupdir/ -type f -mtime +30 -delete

# Create the Backup
# export PATH=$PATH:/path/to/xtrabackup
# innobackupex --slave-info --user=$username --password=$password --no-timestamp /path/to/backupdir/db.$now 1>/path/to/backupdir/db.$now.log 2>&1
xtrabackup \
    --host=127.0.0.1 --port=3306 \
    --user=$username --password=$password \
    --datadir=/srv/datas/mariadb/ \
    --backup --target_dir=$backupdir/$now 1> $backupdir/$now.log 2>&1

	#--compress \
    #--compress-threads=4 \

success=`grep -c "completed OK" $backupdir/$now.log`

# Prepare the Backup
if [ "$success" -eq "1" ]
then
        xtrabackup --prepare --target_dir=$backupdir/$now 1>> $backupdir/$now.log 2>&1
fi

success=`grep -c "completed OK" $backupdir/$now.log`

# Prepare the Backup
if [ "$success" -eq "2" ]
then
    #tar/compress result 
    tar -zcf $backupdir/$now.tar.gz \
       -C $backupdir \
       $now
    
    rm -rf $backupdir/$now
    
    echo "Mariadb: Ok"
else
    echo "Mariadb: Fail"    
fi



