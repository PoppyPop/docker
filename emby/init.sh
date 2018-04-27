#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/emby

sudo cp -f docker-compose.yml /srv/confs/emby/

#datas
docker volume create emby-datas --label backup=yes

docker volume create -o type=none -o device=/datas -o o=bind emby-local-datas

#backs
sudo mkdir -p /srv/backs/emby
