#!/bin/bash
#

mkdir -p env

if [ ! -f env/db.env ] 
then

	DBROOTPASS=$(openssl rand -base64 12)	
	
	cp conf-sample/db.env env/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" env/db.env

	
	echo -e $"=========== postgres ==========="
	echo "base     : ${DBROOTPASS}"
	echo -e $"=========== /postgres ==========="
else
	echo "config file already exist" 
fi
