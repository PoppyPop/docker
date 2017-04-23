#!/bin/bash
#

cd fluentd
sudo docker build -t poppypop/fluentd:alpine --rm .
cd -
