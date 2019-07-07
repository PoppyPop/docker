#!/bin/bash
#

mkdir -p env

if [ ! -f env/jeedom.env ] 
then

	ROOTPASS=$(openssl rand -base64 12)	
	
	cp env-sample/jeedom.env env/jeedom.env
	sed -i "s|{ROOTPASS}|${ROOTPASS}|g" env/jeedom.env

	
	echo -e $"=========== ssh jeedom ==========="
	echo "base     : ${ROOTPASS}"
	echo -e $"=========== /ssh jeedom ==========="
else
	echo "config file already exist" 
fi
