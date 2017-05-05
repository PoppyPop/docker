#!/bin/bash
#

sudo mkdir -p /srv/confs/bind

sudo cp -f docker-compose.yml /srv/confs/bind/

sudo cp -f conf/* /srv/confs/bind/