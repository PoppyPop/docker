#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=$1

# Restore Baskup file
if [ ! -d "$backupDir" ]; then

	result=""

	until [ "$result" == "h" ] || [ "$result" == "d" ]; do
		read -p "1hr (h) or 1Day (d) ? (Ctrl-C to stop)" result
	done

	maxage="1d"
	if [ "$result" == "h" ]; then
		maxage="1h"
	fi

	mkdir "$backupDir"
	rclone copy --max-age $maxage  gdsecret:/$(hostname -f)/daily/ "$backupDir"
else
	echo "Directory already exist, restore already in progress"
fi
