#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/ldap

sudo cp -f docker-compose.yml /srv/confs/ldap/

#datas
docker volume create openldap-data --label backup=yes

#backs
sudo mkdir -p /srv/backs/ldap