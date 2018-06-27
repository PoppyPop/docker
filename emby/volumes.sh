#!/bin/bash
#

#datas
docker volume create emby-datas --label backup=yes

docker volume create -o type=none -o device=/datas -o o=bind emby-local-datas --label backup=no