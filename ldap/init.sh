#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/ldap/

sudo cp -f docker-compose.yml /srv/confs/ldap/

#docker network
sudo docker network create --opt com.docker.network.driver.mtu=9000 ldap-backend

