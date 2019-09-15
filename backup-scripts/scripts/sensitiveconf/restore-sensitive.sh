#!/bin/bash
#

src=${BASH_SOURCE%/*}

restore_src=$1
archive_name="local-sensitive"
restore_dest=/opt/poppypop/

$src/../restore-dir.sh $archive_name "$restore_src" "$restore_dest"

if [ $? -eq 0 ]
then
	echo "Sensitive: Ok"
else
    echo "Sensitive: Fail"  
    exit 1  
fi

read -p "Change owner to: [empty does nothing] " newowner

if [ ! -z "$newowner" ]; then
	echo "Changing to $newowner"
	chown -R $newowner:$newowner "$restore_dest"
fi