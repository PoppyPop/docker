#!/bin/bash
#

# for debug use :
#docker run -ti --rm -v /srv/docker/web/data:/srv/http --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name myfpm poppypop/php-fpm 

docker run -ti --rm -p 3128:3128 --name squid poppypop/squid 

#docker run -ti --rm -p 3128:3128 --name squid poppypop/squid /bin/bash