#!/bin/bash
#

#datas
docker volume create mariadb-config
docker volume create mariadb-datas --label backup=yes
