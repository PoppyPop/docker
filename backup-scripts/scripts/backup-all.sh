#!/bin/bash
#

src=${BASH_SOURCE%/*}

# BDD
echo "Backup Bdd"
${src}/mariadb/backup-mariadb.sh

# Elastic
echo "Backup Elastic"
${src}/elastic/backup-elastic.sh

# Web
echo "Web"
${src}/web/backup-web.sh


# End : Sync to gdrive
echo "GSync"
${src}/gdrive-sync.sh