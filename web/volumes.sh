#!/bin/bash
#

docker volume create -o type=none -o device=/srv/datas/web -o o=bind web-datas

docker volume create web-conf 
#docker volume create transmission-conf --label backup=yes
