#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/nextcloud

sudo cp -f docker-compose.yml /srv/confs/nextcloud/
sudo cp -f db.env /srv/confs/nextcloud/
sudo cp -f nginx.conf /srv/confs/nextcloud/
