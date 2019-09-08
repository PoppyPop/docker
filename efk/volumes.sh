#!/bin/bash
#

#docker volume create -o type=none -o device=/srv/backs/efk -o o=bind elastic-backup --label backup=no
docker volume create -o type=none -o device=/srv/datas/efk -o o=bind elastic-backup --label backup=no

docker volume create elastic1-datas
docker volume create elastic2-datas

docker volume create fluentd-conf


docker volume create es-certs --label backup=no