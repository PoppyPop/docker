#!/bin/bash
#

read -p "adguard auth bearer: " BEARER

sudo mkdir -p /srv/confs/nginx-proxy/env/

printf "BEARER=${BEARER}\n" | sudo tee /srv/confs/nginx-proxy/env/adguard.env
