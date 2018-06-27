#!/bin/bash
#

if [ ! -f openldap/conf/slapd.env ] 
then
	SUFFIX="dc=moot,dc=fr"
	ROOTDN="cn=admin,${SUFFIX}"
	ROOTPW=$(openssl rand -base64 12)
	
	cp openldap/slapd.env.sample openldap/slapd.env
	sed -i "s|{SUFFIX}|${SUFFIX}|g" openldap/slapd.env
	sed -i "s|{ROOTDN}|${ROOTDN}|g" openldap/slapd.env
	sed -i "s|{ROOTPW}|${ROOTPW}|g" openldap/slapd.env
	
	cp fusiondirectory/fusiondirectory.conf.sample fusiondirectory/fusiondirectory.conf
	sed -i "s|{SUFFIX}|${SUFFIX}|g" fusiondirectory/fusiondirectory.conf
	sed -i "s|{ROOTDN}|${ROOTDN}|g" fusiondirectory/fusiondirectory.conf
	sed -i "s|{ROOTPW}|${ROOTPW}|g" fusiondirectory/fusiondirectory.conf
	
	echo -e $"=========== INFOS ==========="
	echo "SUFFIX   : ${SUFFIX}" 
	echo "ROOTDN   : ${ROOTDN}" 
	echo "ROOTPW   : ${ROOTPW}"
	echo -e $"=========== INFOS ==========="
else
	echo "config file already exist" 
fi
