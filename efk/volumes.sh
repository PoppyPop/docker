#!/bin/bash
#

docker volume create -o type=none -o device=/srv/datas/efk/backup -o o=bind elastic-backup

docker volume create elastic1-datas
docker volume create elastic2-datas

docker volume create fluent-conf