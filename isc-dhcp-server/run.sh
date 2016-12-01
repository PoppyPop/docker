#!/bin/bash
#

cd /srv/docker/dchpd &>/dev/null

# --log-opt tag="{{.ImageName}}/{{.Name}}"

docker run -d --restart=always --net=host -v "$PWD":/data --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect=true --name mydhcpd poppypop/dhcpd "$@"

#docker run -d --restart=always --net=host -v "$PWD":/data --name mydhcpd poppypop/dhcpd "$@"

# for debug use :
#docker run -ti --rm --net=host -v /srv/docker/dchpd:/data --log-driver=fluentd --log-opt fluentd-address=127.0.0.1:24224 --log-opt fluentd-async-connect --name mydhcpd poppypop/dhcpd "$@"

cd - &>/dev/null
