#!/bin/bash
#

sudo mkdir -p /downloads/transmission
sudo mkdir -p /srv/confs/transmission

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/transmission/