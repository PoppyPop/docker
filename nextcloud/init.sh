#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/nextcloud

sudo cp -f docker-compose.yml /srv/confs/nextcloud/

if id "nextcloud" >/dev/null 2>&1; then
        echo "user exists"
else
        useradd nextcloud --uid 82 -r --shell /bin/false
fi
