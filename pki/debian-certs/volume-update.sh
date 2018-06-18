#!/bin/sh
#

docker run -ti --rm -v debian-certs:/etc/ssl/certs -v ${PWD}/update.sh:/update.sh debian:stretch-slim /update.sh
