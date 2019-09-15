#!/bin/bash
#

src=${BASH_SOURCE%/*}

restore_src=$1
archive_name="local-elastic"
restore_dest=/srv/datas/efk

$src/../restore-dir.sh $archive_name "$restore_src" "$restore_dest"

if [ $? -eq 0 ]
then
	echo "Elastic: Ok"
else
    echo "Elastic: Fail"  
    exit 1  
fi