#!/bin/bash
#

if [ ! -f conf/slapd.conf ] 
then
	PASSCONFIG=$(openssl rand -base64 12 | sha512sum | cut -d' ' -f1)

	cp conf/slapd.conf.sample conf/slapd.conf
	sed -i "s|{PASSCONFIG}|{SHA512}${PASSCONFIG}|g" conf/slapd.conf
fi


docker build -t poppypop/ldap --rm .
