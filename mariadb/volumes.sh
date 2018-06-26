#!/bin/bash
#

#docker volume create -o type=none -o device=/srv/datas/efk/backup -o o=bind elastic-backup

#datas
docker volume create mariadb-config
docker volume create mariadb-datas --label backup=yes
