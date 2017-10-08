#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/ldap

sudo cp -f docker-compose.yml /srv/confs/ldap/

#datas
sudo mkdir -p /srv/datas/ldap/openldap

#backs
sudo mkdir -p /srv/backs/ldap