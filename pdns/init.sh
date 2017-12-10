#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/pdns

sudo cp -f docker-compose.yml /srv/confs/pdns/
sudo cp -f db.env /srv/confs/pdns/
sudo cp -f pdns-admin.env /srv/confs/pdns/
sudo cp -f pdns.env /srv/confs/pdns/

#datas
docker volume create pdns-mysql --label backup=yes
docker volume create pdns-admin-upload --label backup=yes

#docker network
#sudo docker network create --opt com.docker.network.driver.mtu=9000 ldap-backend

#backs
sudo mkdir -p /srv/backs/pdns