#!/bin/bash
#

if [ ! -f install-vm-fedora.sh ] 
then
	ADMINPASS=$(openssl rand -base64 12)
	DSPASS=$(openssl rand -base64 12)
	
	
	cp install-vm-fedora.sh.sample install-vm-fedora.sh
	sed -i "s|{ADMINPASS}|${ADMINPASS}|g" install-vm-fedora.sh
	sed -i "s|{DSPASS}|${DSPASS}|g" install-vm-fedora.sh
	
	echo -e $"=========== IPA ==========="
	echo "ADMINPASS  : ${ADMINPASS}"
	echo "DSPASS     : ${DSPASS}"
	echo -e $"=========== /IPA ==========="
else
	echo "config file already exist" 
fi