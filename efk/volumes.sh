#!/bin/bash
#

docker volume create -o type=none -o device=/srv/backs/efk -o o=bind elastic-backup --label backup=no

docker volume create elastic1-datas
docker volume create elastic2-datas

docker volume create fluent-conf