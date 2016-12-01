#!/bin/bash
#

cd /srv/docker/mariadb &>/dev/null

# --log-opt tag="{{.ImageName}}/{{.Name}}"

docker run -d --restart=always -v "$PWD"/datas:/var/lib/mysql -v "$PWD"/config:/etc/mysql/conf.d -p 3306:3306 --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name mymariadb mariadb "$@"

#docker run -d --restart=always -v "$PWD"/datas:/var/lib/mysql -v "$PWD"/config:/etc/mysql/conf.d -p 3306:3306 --name mymariadb mariadb "$@"

# for debug use :
#docker run -ti --rm -v /srv/docker/mariadb/datas:/var/lib/mysql -v /srv/docker/mariadb/config:/etc/mysql/conf.d -p 3306:3306 --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect --name mymariadb mariadb "$@"

cd - &>/dev/null
