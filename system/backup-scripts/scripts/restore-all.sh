#!/bin/bash
#

src=${BASH_SOURCE%/*}

backupDir=~/restorefile

# Restore backup files
echo "Restore backup files"
${src}/restore-downloadBackup.sh $backupDir

read -p "Start restore ? (Ctrl-C to stop)"

# Sensitive
read -p  "Sensitive (Press to start)"
${src}/sensitiveconf/restore-sensitive.sh $backupDir

# gitConf
read -p  "Git Conf (Press to start)"
${src}/gitconf/restore.sh

# Elastic
# Need config restore before
read -p  "Elastic (Press to start)"
${src}/elastic/restore-elastic.sh $backupDir

# Web
# Need config restore before
read -p  "Web (Press to start)"
${src}/web/restore-web.sh $backupDir

# Docker
# Need config restore before
read -p  "Docker Volume (Press to start)"
${src}/docker/restore-docker-volumes.sh $backupDir