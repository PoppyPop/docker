#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/nextcloud

sudo cp -f docker-compose.yml /srv/confs/nextcloud/

#datas
docker volume create nextcloud-data --label backup=yes

#backs
#sudo mkdir -p /srv/backs/ldap