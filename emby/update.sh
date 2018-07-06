#!/bin/bash
#

docker-compose pull

./autoorganize.sh

sudo systemctl reload docker-compose@emby