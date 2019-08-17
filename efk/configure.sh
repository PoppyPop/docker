#!/bin/bash
#

mkdir -p env

if [ ! -f env/elastic.env ] 
then

	ROOTPASS=$(openssl rand -base64 12)	
	
	cp env-sample/elastic.env env/elastic.env
	sed -i "s|{ROOTPASS}|${ROOTPASS}|g" env/elastic.env

	
	echo -e $"=========== elastic ==========="
	echo "base     : ${ROOTPASS}"
	echo -e $"=========== elastic ==========="
else
	echo "config file already exist" 
fi
