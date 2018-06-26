#!/bin/bash
#

sudo docker network create --opt com.docker.network.driver.mtu=9000 proxy-net

#conf
sudo mkdir -p /srv/confs/nginx-proxy/

sudo cp -f docker-compose.yml /srv/confs/nginx-proxy/
