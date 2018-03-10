#!/bin/bash
#

if [ ! -f openldap/conf/slapd.env ] 
then
	SUFFIX="dc=moot,dc=fr"
	ROOTDN="cn=admin,${SUFFIX}"
	ROOTPW=$(openssl rand -base64 12)
	
	cp openldap/conf/slapd.env.sample openldap/conf/slapd.env
	sed -i "s|{SUFFIX}|${SUFFIX}|g" openldap/conf/slapd.env
	sed -i "s|{ROOTDN}|${ROOTDN}|g" openldap/conf/slapd.env
	sed -i "s|{ROOTPW}|${ROOTPW}|g" openldap/conf/slapd.env
	
	cp fusiondirectory/fusiondirectory.conf.sample fusiondirectory/fusiondirectory.conf
	sed -i "s|{ROOTPW}|${ROOTPW}|g" fusiondirectory/fusiondirectory.conf
	
	echo -e $"=========== INFOS ==========="
	echo "SUFFIX   : ${SUFFIX}" 
	echo "ROOTDN   : ${ROOTDN}" 
	echo "ROOTPW   : ${ROOTPW}"
	echo -e $"=========== INFOS ==========="
else
	echo "config file already exist" 
fi