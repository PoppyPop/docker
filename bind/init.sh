#!/bin/bash
#

sudo mkdir -p /srv/confs/bind

sudo cp -f docker-compose.yml /srv/confs/bind/

sudo mkdir -p /srv/confs/bind/bind/etc/

sudo cp -f conf/* /srv/confs/bind/bind/etc/

sudo chown -R 102:105 /srv/confs/bind/bind/