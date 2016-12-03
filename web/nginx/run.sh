#!/bin/bash
#

cd /srv/docker/web &>/dev/null

# --log-opt tag="{{.ImageName}}/{{.Name}}"

docker run -d --restart=always -p 80:80 --link myfpm:phpfpm -v "$PWD"/nginx:/etc/nginx/conf.d:ro -v "$PWD"/data:/usr/share/nginx/html:ro --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name mynginx nginx:alpine 


#/etc/nginx/conf.d/
#docker run -d --restart=always -p 80:80 -v "$PWD":/usr/share/nginx/html:ro --name mynginx nginx:alpine 


# for debug use :
#docker run -ti --rm -p 80:80 -v /srv/docker/web:/usr/share/nginx/html:ro --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name mynginx nginx:alpine

cd - &>/dev/null
