#!/bin/bash
#

read -p "nsupdate secret: " NSUSEC

sudo mkdir -p /srv/confs/nginx-proxy/env/

printf "NSKEY=${NSUSEC}\n" | sudo tee /srv/confs/nginx-proxy/env/nsupdate.env
