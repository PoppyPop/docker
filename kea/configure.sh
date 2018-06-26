#!/bin/bash
#
# NextCloud

if [ ! -f db.env ] 
then
	DBROOTNAME=kea
	DBROOTPASS=$(openssl rand -base64 12)	
	DBROOTUSER=root
	
	cp conf-sample/db.env.sample env/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" env/db.env
	
	cp conf-sample/kea.env.sample env/kea.env
	sed -i "s|{DBROOTNAME}|${DBROOTNAME}|g" env/kea.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" env/kea.env
	sed -i "s|{DBROOTUSER}|${DBROOTUSER}|g" env/kea.env

	if [ -f /srv/confs/pdns/env/pdns-api.env ]; then 
		source /srv/confs/pdns/env/pdns-api.env
		
		echo -n "Enter pdns fqdn domain (ending with a dot) (default:moot.fr.) [ENTER]: "
		read DOMAIN

		echo -n "Enter pdns endpoint (default:http://dns-api.moot.fr) [ENTER]: "
		read ENDPOINT


		DOMAIN=${DOMAIN:-moot.fr.}
		ENDPOINT=${ENDPOINT:-http://dns-api.moot.fr}

		cp conf-sample/hook.sh.sample conf/hook.sh
		sed -i "s|{PDNS_api_key}|${PDNS_api_key}|g" conf/hook.sh
		sed -i "s|{DOMAIN}|${DOMAIN}|g" conf/hook.sh
		sed -i "s|{ENDPOINT}|${ENDPOINT}|g" conf/hook.sh

		chmod +x conf/hook.sh
	fi
	

	echo -e $"=========== kea ==========="
	echo "base     : ${DBROOTPASS}"
	echo "domain   : ${DOMAIN}"
	echo "endpoint : ${ENDPOINT}"
	echo -e $"=========== /kea ==========="
else
	echo "config file already exist" 
fi
