#!/bin/bash
#

src=${BASH_SOURCE%/*}

restore_src=$1
archive_name="local-sensitive"
configdir=/opt/poppypop/

#$src/../restore-dir.sh $archive_name "$restore_src" "$configdir"

read -p "Change owner to: [empty does nothing] " newowner

if [ ! -z "$newowner" ]; then
	echo "Changing to $newowner"
	chown -R $newowner:$newowner "$configdir"
fi