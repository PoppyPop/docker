#!/bin/bash
#

sudo mkdir -p /srv/confs/web

sudo mkdir -p /srv/datas/web

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/web/

#docker network
sudo docker network create --opt com.docker.network.driver.mtu=9000 webbackend


