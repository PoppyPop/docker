#!/bin/bash
#

src=${BASH_SOURCE%/*}

restore_src=$1
archive_name="local-web"
restore_dest=/srv/datas/web

$src/../restore-dir.sh $archive_name "$restore_src" "$restore_dest"

if [ $? -eq 0 ]
then
	echo "Web: Ok"
else
    echo "Web: Fail"  
    exit 1  
fi
