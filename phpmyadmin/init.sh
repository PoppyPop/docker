#!/bin/bash
#

sudo mkdir -p /srv/confs/phpmyadmin

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/phpmyadmin/
