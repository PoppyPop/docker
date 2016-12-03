#!/bin/bash
#

docker run -ti --rm -v /srv/docker/mariadb/data:/var/lib/mysql -v /srv/docker/mariadb/config:/etc/mysql/conf.d -p 3306:3306 --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name mymariadb mariadb
