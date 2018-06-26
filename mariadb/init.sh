#!/bin/bash
#

sudo mkdir -p /srv/confs/mariadb

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/mariadb/
