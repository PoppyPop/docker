#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/kea

sudo cp -f docker-compose.yml /srv/confs/kea/
sudo cp -Rf conf/ /srv/confs/kea/


#datas
#docker volume create kea-mysql --label backup=yes
docker volume create kea-pgsql --label backup=yes

#docker network
#sudo docker network create --opt com.docker.network.driver.mtu=9000 ldap-backend

#backs
sudo mkdir -p /srv/backs/kea
