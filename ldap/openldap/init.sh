#!/bin/bash
#

if [ ! -f conf/slapd.ldif ] 
then
	PASSCONFIG=$(openssl rand -base64 12)
	PASSCRYPT=$(mkpasswd -m SHA-512 ${PASSCONFIG})
	
	cp conf/slapd.ldif.sample conf/slapd.ldif
	sed -i "s|{PASSCONFIG}|{CRYPT}${PASSCRYPT}|g" conf/slapd.ldif
	
	echo -e $"=========== INFOS ==========="
	echo "bind     : cn=admin,dc=moot" 
	echo "pass     : ${PASSCONFIG}"
	echo -e $"=========== INFOS ==========="
else
	echo "config file already exist" 
fi