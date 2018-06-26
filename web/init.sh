#!/bin/bash
#

sudo mkdir -p /srv/confs/web
sudo mkdir -p /srv/confs/web/conf.d

sudo mkdir -p /srv/datas/web

#conf systemd
sudo cp -f docker-compose.yml /srv/confs/web/

#conf nginx
sudo cp -f nginx/conf/nginx.conf /srv/confs/web/
sudo cp -f nginx/conf/conf.d/* /srv/confs/web/conf.d/

#conf varnish
sudo cp -f varnish/default.vcl /srv/confs/web/

#docker network
sudo docker network create --opt com.docker.network.driver.mtu=9000 webbackend


