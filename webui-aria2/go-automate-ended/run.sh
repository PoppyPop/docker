#!/bin/bash
#

# for debug use :
#docker run -ti --rm -v /srv/docker/web/data:/srv/http --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name myfpm poppypop/php-fpm 

docker run -ti --rm -v /downloads/aria2/Downloads:/downloads -v /downloads/aria2/Ended:/ended -v /downloads/aria2/Extract:/extract --name go-automated-ended poppypop/go-automated-ended 
#--net=host 
#docker run -ti --rm -v /downloads/aria2/Downloads:/downloads -v /downloads/aria2/Ended:/ended -v /downloads/aria2/Extract:/extract -v pico-atrier:/nfs:nocopy --name go-automated-ended --user "1001:65540" poppypop/go-automated-ended /bin/sh
