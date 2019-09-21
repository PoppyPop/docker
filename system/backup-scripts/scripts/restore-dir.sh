#!/bin/sh
#

# Fail on error
set -e

getLatestFile () {
	local dir=$1
	local suffix=$2
	
	local latest
		
	for file in "$dir/$suffix"*; do
		if [ ! -e "$file" ]; then continue; fi
		if [ -z "$latest" ]; then latest=$file; fi
		if [ $file -nt $latest ]; then latest=$file; fi
	done
	echo "$latest"
}

if [ -z "$1" ]; then
	echo "Archive is mandatory"
	exit 1
fi

# What to restore. 
archive_name="$1"

# archive source
if [ -z "$2" ]; then
	restore_src="/backup"
else
	restore_src="$2"
fi

# Where to restore
if [ -z "$3" ]; then
	restore_dest="/volume"
else
	restore_dest="$3"
fi

archive=$( getLatestFile $restore_src $archive_name )
#getLatestFile $restore_src $archive_name

if [ ! -z "$archive" ]; then
	# --keep-newer-files (remplace -k mais pas compatible busybox)
	tar -C "$restore_dest" -k -xj -f "$archive"
else
	echo "Restore $archive_name Failed : No archive matching"
	exit 1
fi

# Print end status message.
echo "Restore $archive_name finished"

