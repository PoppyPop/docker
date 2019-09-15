#!/bin/bash
#

# Fail on error
set -e

src=${BASH_SOURCE%/*}

backup_app=$(readlink -f $src/../backup-dir.sh)


docker run --rm  -v $1:/volume -v /srv/backs:/backup -v $backup_app:/backup-dir.sh alpine \
	/backup-dir.sh $1
