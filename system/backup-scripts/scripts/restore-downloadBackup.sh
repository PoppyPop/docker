#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=$1

# Restore Baskup file
if [ ! -d "$backupDir" ]; then
	mkdir "$backupDir"
	rclone copy --max-age 1d  gdsecret:/$(hostname -f)/daily/ "$backupDir"
fi
