#!/bin/bash
#

docker run -ti --rm -v alpine-certs:/etc/ssl/certs:ro \
      -v openldap-certs:/etc/ssl/ldap:ro \
      -v openldap-data:/var/lib/openldap/openldap-data \
      -v openldap-config:/etc/openldap/slapd.d \
	  -p 389:389 -p 636:636 \
	  poppypop/docker-openldap $1
	  