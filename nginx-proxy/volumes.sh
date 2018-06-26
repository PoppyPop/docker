#!/bin/bash
#

#datas
docker volume create certs --label backup=yes

docker volume create ngproxy-tmpl

#docker volume create -o type=none -o device=/datas/nextcloud -o o=bind nextcloud-data