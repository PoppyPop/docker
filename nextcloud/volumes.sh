#!/bin/bash
#

#datas
docker volume create nextcloud-base --label backup=yes
docker volume create nextcloud-apps --label backup=yes
docker volume create nextcloud-config --label backup=yes

docker volume create nextcloud-nginx

docker volume create -o type=none -o device=/datas/nextcloud -o o=bind nextcloud-data