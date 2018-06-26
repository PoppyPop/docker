#!/bin/bash
#

#docker volume create -o type=none -o device=/srv/datas/efk/backup -o o=bind elastic-backup

#datas
docker volume create openldap-config --label backup=yes
docker volume create openldap-data --label backup=yes
docker volume create openldap-certs --label backup=yes

docker volume create fusiond-config