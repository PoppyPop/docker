#!/bin/bash
#

#docker volume create -o type=none -o device=/srv/datas/efk/backup -o o=bind elastic-backup

docker volume create kea-pgsql --label backup=yes
docker volume create kea-conf