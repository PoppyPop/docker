#!/bin/bash
#

# docker run -ti --rm -v /srv/docker/dchpd:/data --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect --name ldap poppypop/ldap


# docker run -d -p 12080:80 -e LDAP_DOMAIN=example.com -e LDAP_ROOTPW=secret -e LDAP_ROOTDN="cn=admin,dc=example,dc=com" --link ldap:ldap-server mcreations/fusiondirectory

docker run -ti --rm --name fusiond -p 12080:80 poppypop/fusiond $1
