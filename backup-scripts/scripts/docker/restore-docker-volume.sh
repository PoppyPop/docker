#!/bin/bash
#

src=${BASH_SOURCE%/*}

restore_src=$1
restore_volume=$2

restore_app=$(readlink -f $src/../restore-dir.sh)

docker run --rm  -v $restore_volume:/volume -v $restore_src:/backup -v $restore_app:/restore-dir.sh alpine \
	/restore-dir.sh $restore_volume
	
if [ $? -eq 0 ]
then
	echo "Docker $restore_volume: Ok"
else
    echo "Docker $restore_volume: Fail"  
    exit 1  
fi
