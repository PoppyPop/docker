#!/bin/bash
#

#datas
docker volume create tvheadend-config --label backup=yes

docker volume create -o type=none -o device=/datas/tvheadend -o o=bind tvheadend-datas --label backup=no