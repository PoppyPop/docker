#!/bin/bash
#

docker run -d --restart=always --net=host -v /srv/docker/dchpd:/data poppypop/dhcpd "$@"
