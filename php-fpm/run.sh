#!/bin/bash
#

cd /srv/docker/web &>/dev/null

# --log-opt tag="{{.ImageName}}/{{.Name}}"

docker run -d --restart=always -v "$PWD"/data:/srv/http --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name myfpm poppypop/php-fpm 

#docker run -d --restart=always -v "$PWD"/data:/srv/http --name myfpm poppypop/php-fpm 

# for debug use :
#docker run -ti --rm -v /srv/docker/web/data:/srv/http --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name myfpm poppypop/php-fpm 

cd - &>/dev/null
