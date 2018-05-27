#!/bin/sh
#

docker run -t --rm -v alpine-certs:/etc/ssl/certs -v ${PWD}/update.sh:/update.sh alpine /update.sh
