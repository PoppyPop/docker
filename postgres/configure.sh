#!/bin/bash
#

mkdir -p conf

if [ ! -f conf/db.env ] 
then

	DBROOTPASS=$(openssl rand -base64 12)	
	
	cp conf-sample/db.env conf/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" conf/db.env

	
	echo -e $"=========== postgres ==========="
	echo "base     : ${DBROOTPASS}"
	echo -e $"=========== /postgres ==========="
else
	echo "config file already exist" 
fi
