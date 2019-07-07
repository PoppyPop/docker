#!/bin/bash
#

mkdir -p env

if [ ! -f env/db.env ] 
then

	DBROOTPASS=$(openssl rand -base64 12)	
	
	cp conf-sample/db.env env/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" env/db.env

	
	echo -e $"=========== mariadb ==========="
	echo "base     : ${DBROOTPASS}"
	echo -e $"=========== /mariadb ==========="
else
	echo "config file already exist" 
fi
