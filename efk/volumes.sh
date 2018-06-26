#!/bin/bash
#

docker volume create -o type=none -o device=/srv/backs/efk -o o=bind elastic-backup

docker volume create elastic1-datas
docker volume create elastic2-datas

docker volume create fluent-conf