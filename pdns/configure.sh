#!/bin/bash
#
# NextCloud

if [ ! -f db.env ] 
then
	DBROOTPASS=$(openssl rand -base64 12)	
	APIKEY=$(openssl rand -base64 12)
	WEBPASS=$(openssl rand -base64 12)
	
	cp db.env.sample db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" db.env
	
	cp pdns-api.env.sample pdns-api.env
	sed -i "s|{APIKEY}|${APIKEY}|g" pdns-api.env
	sed -i "s|{WEBPASS}|${WEBPASS}|g" pdns-api.env	

	cp pdns-recursor.env.sample pdns-recursor.env

	cp pdns.env.sample pdns.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" pdns.env
	
	cp pdns-admin.env.sample pdns-admin.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" pdns-admin.env
	sed -i "s|{APIKEY}|${APIKEY}|g" pdns-admin.env
	
	read -p "LDAP User ? " LDAPUSER
	sed -i "s|{LDAPUSER}|${LDAPUSER}|g" pdns-admin.env
	
	read -s -p "LDAP Pass ? " LDAPPASS; echo
	sed -i "s|{LDAPPASS}|${LDAPPASS}|g" pdns-admin.env


	
	echo -e $"=========== pdns ==========="
	echo "base     : ${DBROOTPASS}"
	echo "api      : ${APIKEY}"
	echo "pass     : ${WEBPASS}"
	echo -e $"=========== /pdns ==========="
else
	echo "config file already exist" 
fi
