#!/bin/bash
#

cd /srv/docker/dchpd

sudo docker run -d --restart=always --net=host -v "$PWD":/data --name mydhcpd poppypop/dhcpd "$@"

# for debug use :
#sudo docker run -ti --rm --net=host -v "$PWD":/data --name mydhcpd poppypop/dhcpd "$@"

cd -