#!/bin/bash
#

# docker run -ti --rm -v /srv/docker/dchpd:/data --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect --name ldap poppypop/ldap

docker run -ti --rm -v /srv/datas/ldap/openldap:/var/lib/openldap/openldap-data -v /etc/ssl/private:/etc/ssl/private:ro -p 389:389 -p 636:636 --name ldap poppypop/ldap $1
