#!/bin/bash
#
# NextCloud

mkdir -p conf

if [ ! -f env/db.env ] 
then
	#sudo apt install bind9utils
	#TSIGFILE=$(dnssec-keygen -a HMAC-SHA512 -b 512 -n HOST TSIG)
	#TSIG=$(cat ${TSIGFILE}.key | awk '{print $7$8}')

	#rm ${TSIGFILE}.key
	#rm ${TSIGFILE}.private

	DBROOTPASS=$(openssl rand -base64 12)	
	APIKEY=$(openssl rand -base64 12)
	WEBPASS=$(openssl rand -base64 12)
	
	cp conf-sample/db.env.sample env/db.env
	sed -i "s|{DBROOTPASS}|${DBROOTPASS}|g" env/db.env
	
	cp conf-sample/pdns-api.env.sample env/pdns-api.env
	sed -i "s|{APIKEY}|${APIKEY}|g" env/pdns-api.env
	sed -i "s|{WEBPASS}|${WEBPASS}|g" env/pdns-api.env	

	cp conf-sample/pdns-recursor.env.sample env/pdns-recursor.env

	cp conf-sample/pdns.env.sample env/pdns.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" env/pdns.env
	
	cp conf-sample/pdns-admin.env.sample env/pdns-admin.env
	sed -i "s|{PASSDB}|${DBROOTPASS}|g" env/pdns-admin.env
	sed -i "s|{APIKEY}|${APIKEY}|g" env/pdns-admin.env
	
	read -p "LDAP User ? " LDAPUSER
	sed -i "s|{LDAPUSER}|${LDAPUSER}|g" env/pdns-admin.env
	
	read -s -p "LDAP Pass ? " LDAPPASS; echo
	sed -i "s|{LDAPPASS}|${LDAPPASS}|g" env/pdns-admin.env

	#echo "TSIG=${TSIG}" > env/pdns-tsig.env
	
	echo -e $"=========== pdns ==========="
	echo "base     : ${DBROOTPASS}"
	echo "api      : ${APIKEY}"
	echo "pass     : ${WEBPASS}"
	echo "TSIG     : ${TSIG}"
	echo -e $"=========== /pdns ==========="
else
	echo "config file already exist" 
fi
