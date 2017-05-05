#!/bin/bash
#

LOCKFILE="./copyFile.lock"
LOCALDIR="./Ended/"
DLDIR="./Downloads/"
MNTDIR="/tmp/pico-atrier"
REMOTEIP="192.168.0.250"
REMOTEDIR="volume1/ATrier"

if [ ! -e $LOCKFILE ]
then
	touch $LOCKFILE
else
	echo "Already running"
	exit
fi

if [ ! -d $MNTDIR ]
then
mkdir $MNTDIR
fi

cd $LOCALDIR > /dev/null
find . -depth -type d -empty -delete
cd - > /dev/null

cd $DLDIR > /dev/null
find . -depth -type d -empty -delete
cd - > /dev/null

if [ "$(ls -A $LOCALDIR)" ]; then
    sudo mount -t nfs -o rw,user,users,noauto,async $REMOTEIP:$REMOTEDIR $MNTDIR

	if [ $? -eq 0 ]
	then
		rsync -rltDvW --remove-sent-files --chmod=0777 $LOCALDIR $MNTDIR
		
		chmod -R a+rw $MNTDIR
		
		sudo umount $MNTDIR
	else
		echo "Unable to mount $MNTDIR"
	fi
else
    echo "$LOCALDIR is Empty"
fi

rm $LOCKFILE
