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

	if [ -f /srv/confs/pdns/conf/pdns-api.env ]; then 
		source /srv/confs/pdns/conf/pdns-api.env
		
		echo -n "Enter pdns fqdn domain (ending with a dot) (default:moot.fr.) [ENTER]: "
		read DOMAIN

		echo -n "Enter pdns endpoint (default:http://pdns-api.moot.fr) [ENTER]: "
		read ENDPOINT

		cp hook.sh.sample hook.sh
		sed -i "s|{PDNS_api_key}|${PDNS_api_key}|g" hook.sh
		sed -i "s|{DOMAIN}|${DOMAIN:-moot.fr.}|g" hook.sh
		sed -i "s|{ENDPOINT}|${ENDPOINT:-http://pdns-api.moot.fr}}|g" hook.sh

		chmod +x hook.sh
	fi
	

	echo -e $"=========== kea ==========="
	echo "base     : ${DBROOTPASS}"
	echo "domain   : ${DOMAIN}"
	echo "endpoint : ${ENDPOINT}"
	echo -e $"=========== /kea ==========="
else
	echo "config file already exist" 
fi
