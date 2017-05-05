#!/bin/bash
#

sudo mkdir -p /srv/datas/mariadb
sudo mkdir -p /srv/confs/mariadb

#backs
sudo mkdir -p /srv/backs/mariadb

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/mariadb/

sudo cp -f conf/my.cnf /srv/confs/mariadb/
