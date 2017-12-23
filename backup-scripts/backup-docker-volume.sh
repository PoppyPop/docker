#!/bin/bash
#

# Fail on error
set -e

docker run --rm  -v $1:/volume -v /srv/backs:/backup -v ${PWD}/scripts/backup-dir.sh:/backup-dir.sh alpine \
	/backup-dir.sh $1
