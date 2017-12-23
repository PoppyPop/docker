#!/bin/bash
#
# NextCloud

if [ ! -f db.env ] 
then
	DBROOTNAME=kea
	DBROOTPASS=$(openssl rand -base64 12)	
	DBROOTUSER=root
	
	cp db.env.sample db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" db.env
	
	cp kea.env.sample kea.env
	sed -i "s|{DBROOTNAME}|${DBROOTNAME}|g" kea.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" kea.env
	sed -i "s|{DBROOTUSER}|${DBROOTUSER}|g" kea.env

	echo -e $"=========== kea ==========="
	echo "base     : ${DBROOTPASS}"
	echo -e $"=========== /kea ==========="
else
	echo "config file already exist" 
fi
