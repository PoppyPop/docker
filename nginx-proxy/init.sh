#!/bin/bash
#

sudo docker network create --opt com.docker.network.driver.mtu=9000 proxy-net

#conf
sudo mkdir -p /srv/confs/nginx-proxy/

sudo cp -f docker-compose.yml /srv/confs/nginx-proxy/

sudo cp -f nginx.tmpl /srv/confs/nginx-proxy/nginx.tmpl
#sudo curl https://raw.githubusercontent.com/jwilder/nginx-proxy/master/nginx.tmpl -o /srv/confs/nginx-proxy/nginx.tmpl

sudo cp -f ssl/cfssl_service_data.tmpl /srv/confs/nginx-proxy/cfssl_service_data.tmpl

