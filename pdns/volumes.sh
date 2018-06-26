#!/bin/bash
#

#datas
#docker volume create pdns-mysql --label backup=yes
docker volume create pdns-admin-upload --label backup=yes
docker volume create pdns-pgsql --label backup=yes

#docker volume create -o type=none -o device=/datas/nextcloud -o o=bind nextcloud-data