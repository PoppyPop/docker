#!/bin/bash
#
# NextCloud

if [ ! -f db.env ] 
then
	sudo apt install bind9utils
	TSIGFILE=$(dnssec-keygen -a HMAC-SHA512 -b 512 -n HOST TSIG)
	TSIG=$(cat ${TSIGFILE}.key | awk '{print $7$8}')

	rm ${TSIGFILE}.key
	rm ${TSIGFILE}.private

	DBROOTPASS=$(openssl rand -base64 12)	
	APIKEY=$(openssl rand -base64 12)
	WEBPASS=$(openssl rand -base64 12)
	
	cp conf-sample/db.env.sample conf/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" conf/db.env
	
	cp conf-sample/pdns-api.env.sample conf/pdns-api.env
	sed -i "s|{APIKEY}|${APIKEY}|g" conf/pdns-api.env
	sed -i "s|{WEBPASS}|${WEBPASS}|g" conf/pdns-api.env	

	cp conf-sample/pdns-recursor.env.sample conf/pdns-recursor.env

	cp conf-sample/pdns.env.sample conf/pdns.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" conf/pdns.env
	
	cp conf-sample/pdns-admin.env.sample conf/pdns-admin.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" conf/pdns-admin.env
	sed -i "s|{APIKEY}|${APIKEY}|g" conf/pdns-admin.env
	
	read -p "LDAP User ? " LDAPUSER
	sed -i "s|{LDAPUSER}|${LDAPUSER}|g" conf/pdns-admin.env
	
	read -s -p "LDAP Pass ? " LDAPPASS; echo
	sed -i "s|{LDAPPASS}|${LDAPPASS}|g" conf/pdns-admin.env

	echo "TSIG=${TSIG}" > conf/pdns-tsig.env
	
	echo -e $"=========== pdns ==========="
	echo "base     : ${DBROOTPASS}"
	echo "api      : ${APIKEY}"
	echo "pass     : ${WEBPASS}"
	echo "TSIG     : ${TSIG}"
	echo -e $"=========== /pdns ==========="
else
	echo "config file already exist" 
fi
