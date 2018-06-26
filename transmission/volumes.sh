#!/bin/bash
#

docker volume create -o type=none -o device=/datas/downloads/transmission -o o=bind transmission-datas --label backup=no

docker volume create transmission-conf --label backup=yes
