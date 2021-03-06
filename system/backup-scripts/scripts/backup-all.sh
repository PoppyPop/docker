#!/bin/bash
#

src=${BASH_SOURCE%/*}

# BDD
# echo "Backup Bdd"
# ${src}/mariadb/backup-mariadb.sh

# Elastic
echo "Backup Elastic"
${src}/elastic/backup-elastic.sh

# Web
echo "Web"
${src}/web/backup-web.sh

# Sensitive
echo "Sensitive"
${src}/sensitiveconf/backup-sensitive.sh

# Docker
echo "Docker"
${src}/docker/backup-docker-volumes.sh

# Docker
echo "Clean"
${src}/backup-clean.sh

# End : Sync to remote
echo "Sync"
${src}/backup-sync.sh
