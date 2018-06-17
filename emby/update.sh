#!/bin/bash
#

docker-compose pull

./autoorganize.sh

sudo systemctl restart docker-compose@emby