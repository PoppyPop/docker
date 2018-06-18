#!/bin/bash
#

if [ ! -f openldap/conf/slapd.ssl.env ] 
then

	LDAP_TLS_CA_CRT_FILENAME=/etc/ssl/certs/Moot.fr_CA.pem
	LDAP_TLS_CRT_FILENAME=/etc/ssl/ldap/ldap.moot.fr.crt
	LDAP_TLS_KEY_FILENAME=/etc/ssl/ldap/ldap.moot.fr.key

	cp openldap/slapd.ssl.env.sample openldap/slapd.ssl.env
	sed -i "s|{LDAP_TLS_CA_CRT_FILENAME}|${LDAP_TLS_CA_CRT_FILENAME}|g" openldap/slapd.ssl.env
	sed -i "s|{LDAP_TLS_CRT_FILENAME}|${LDAP_TLS_CRT_FILENAME}|g" openldap/slapd.ssl.env
	sed -i "s|{LDAP_TLS_KEY_FILENAME}|${LDAP_TLS_KEY_FILENAME}|g" openldap/slapd.ssl.env

else
	echo "config file already exist" 
fi
