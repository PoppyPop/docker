#!/bin/bash
#

#docker run -ti --rm -v alpine-certs:/etc/ssl/certs:ro \
#      -v openldap-certs:/etc/ssl/ldap:ro \
#      -v openldap-data:/var/lib/openldap/openldap-data \
#      -v openldap-config:/etc/openldap/slapd.d \
#      -v ${PWD}/openldap/config.ldif:/etc/openldap/config.ldif:ro \
#	  -e LDAP_TLS_CA_CRT_FILENAME=/etc/ssl/certs/ca-cert-Moot.fr_CA.pem.pem \
#	  -e LDAP_TLS_CRT_FILENAME=/etc/ssl/ldap/ldap.moot.fr.crt \
#	  -e LDAP_TLS_KEY_FILENAME=/etc/ssl/ldap/ldap.moot.fr.key \
#	  -p 389:389 -p 636:636 \
#	  poppypop/docker-openldap $1

docker run -ti --rm \
      -v debian-certs:/etc/ssl/certs:ro \
      -v /srv/confs/ldap/fd/:/etc/fusiondirectory/ \
	  -p 4321:80 \
	  poppypop/docker-fusiond $1