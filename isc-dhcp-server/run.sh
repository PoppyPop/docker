#!/bin/bash
#

docker run -ti --rm --net=host -v /srv/docker/dchpd:/data --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect --name mydhcpd poppypop/dhcpd
