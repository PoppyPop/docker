#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/nextcloud

sudo cp -f docker-compose.yml /srv/confs/nextcloud/

#datas
docker volume create nextcloud-base --label backup=yes
docker volume create nextcloud-apps --label backup=yes
docker volume create nextcloud-config --label backup=yes

docker volume create -o type=none -o device=/datas/nextcloud -o o=bind nextcloud-data

#backs
#sudo mkdir -p /srv/backs/ldap