#!/bin/bash
#

# Fail on error
set -e

ALLVOLUME=${1:-0}

# list volumes with backup tag
readarray -t RESULT < <( docker volume ls --format "{{.Label \"backup\"}}|{{.Name}}" )

for i in "${RESULT[@]}"
do
	volume=(${i//|/ })
	
	# One elem so no backup flag
	
	if [ ${#volume[@]} = 1 ]
	then
		if [ "${ALLVOLUME}" == "0" ]; then
			NOBACKUP+=(${volume[0]})
		else
			BACKUP+=(${volume[0]})
		fi
	elif [ ${volume[0]} = "no" ]
	then
		NOBACKUP+=(${volume[1]})
	else 
		BACKUP+=(${volume[1]})
	fi
done

# Define color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "=========================== NOBACKUP ==========================="
for i in "${NOBACKUP[@]}"
do
	echo -e "${RED}$i${NC}"
done

echo "============================ BACKUP ============================"
for i in "${BACKUP[@]}"
do
	echo -e "${GREEN}$i${NC}"
done
# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

parallel ${SCRIPTPATH}/backup-docker-volume.sh ::: ${BACKUP[@]}

if [ $? -eq 0 ]
then
	echo "Docker: Ok"
else
    echo "Docker: Fail"  
    exit 1  
fi
