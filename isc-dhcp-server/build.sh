#!/bin/bash
#

docker build -t poppypop/dhcpd "$@" $(dirname $0)
