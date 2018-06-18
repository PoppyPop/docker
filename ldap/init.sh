#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/ldap

sudo cp -f docker-compose.yml /srv/confs/ldap/
sudo cp -f fusiondirectory/fusiondirectory.conf /srv/confs/ldap/

#datas
docker volume create openldap-config --label backup=yes
docker volume create openldap-data --label backup=yes
docker volume create openldap-certs --label backup=yes

#docker network
sudo docker network create --opt com.docker.network.driver.mtu=9000 ldap-backend

#backs
sudo mkdir -p /srv/backs/ldap
