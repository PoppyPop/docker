#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/pdns

sudo cp -f docker-compose.yml /srv/confs/pdns/

#docker network
#sudo docker network create --opt com.docker.network.driver.mtu=9000 ldap-backend

