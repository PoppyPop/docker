#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=~/restorefile

# Restore Baskup file
if [ ! -d "$backupDir" ]; then
	mkdir "$backupDir"
	rclone copy --max-age 1d  gdsecret:/$(hostname -f)/daily/ "$backupDir"
fi

read -p "Start restore ? (Ctrl-C to stop)"

# Sensitive
echo "Sensitive"
${src}/sensitiveconf/restore-sensitive.sh $backupDir

# Elastic
echo "Elastic"
# ${src}/elastic/restore-elastic.sh $backupDir

# Web
echo "Web"
# ${src}/web/restore-web.sh $backupDir

# Docker
echo "Web"
# ${src}/docker/restore-docker.sh $backupDir