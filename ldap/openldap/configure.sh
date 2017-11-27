#!/bin/bash
#

if [ ! -f conf/slapd.ldif ] 
then
	PASSCONFIG=$(openssl rand -base64 12)
	#PASSCONFIG=secret
	PASSCRYPT=$(mkpasswd -m SHA-512 ${PASSCONFIG})
	#PASSCRYPT=$(slappasswd -h '{CRYPT}' -s ${PASSCONFIG} -c "$6$%.12s")
	
	cp conf/slapd.ldif.sample conf/slapd.ldif
	sed -i "s|{PASSCONFIG}|{CRYPT}${PASSCRYPT}|g" conf/slapd.ldif
	
	cp ../fusiondirectory/fusiondirectory.conf.sample ../fusiondirectory/fusiondirectory.conf
	sed -i "s|{PASSCONFIG}|${PASSCONFIG}|g" ../fusiondirectory/fusiondirectory.conf
	
	echo -e $"=========== INFOS ==========="
	echo "bind     : cn=admin,dc=moot" 
	echo "pass     : ${PASSCONFIG}"
	echo -e $"=========== INFOS ==========="
else
	echo "config file already exist" 
fi