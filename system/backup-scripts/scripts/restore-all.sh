#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=~/restorefile

# Restore backup files
echo "Restore backup files"
${src}/restore-downloadBackup.sh $backupDir

read -p "Start restore ? (Ctrl-C to stop)"

response=""

# Sensitive
read -p  "Sensitive (y to start)" response
if [ "$response" == "y" ]; then
	${src}/sensitiveconf/restore-sensitive.sh $backupDir
fi

# gitConf
read -p  "Git Conf (y to start)" response
if [ "$response" == "y" ]; then
	${src}/gitconf/restore.sh
fi

# Elastic
# Need config restore before
read -p  "Elastic (y to start)" response
if [ "$response" == "y" ]; then
	${src}/elastic/restore-elastic.sh $backupDir
fi

# Web
# Need config restore before
read -p  "Web (y to start)" response
if [ "$response" == "y" ]; then
	${src}/web/restore-web.sh $backupDir
fi

# Docker
# Need config restore before
read -p  "Docker Volume (y to start)" response
if [ "$response" == "y" ]; then
	${src}/docker/restore-docker-volumes.sh $backupDir
fi
