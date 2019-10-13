#!/bin/bash
#
# NextCloud

mkdir -p conf

if [ ! -f env/db.env ] 
then
	DBPASS=$(openssl rand -base64 12)	
	
	mkdir -p env
	
	cp conf-sample/db.env.sample env/db.env
	sed -i "s|{DBPASS}|${DBPASS}|g" env/db.env
	
	echo -e $"=========== phpipam ==========="
	echo "base     : ${DBPASS}"
	echo -e $"=========== /phpipam ==========="
else
	echo "config file already exist" 
fi
