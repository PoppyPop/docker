#!/bin/bash
#

sudo mkdir -p /srv/confs/postgres


#conf systemd
sudo cp -f docker-compose.yml /srv/confs/postgres/

sudo cp -f -r conf /srv/confs/postgres/

