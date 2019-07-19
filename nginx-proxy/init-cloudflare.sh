#!/bin/bash
#

read -p "Cloudflare user: " CFUSER
read -p "Cloudflare password: " CFPASSWORD

docker run -it --rm -v letsencrypt:/volume alpine \
    sh -c "rm -rf /volume/cloudflare.ini ; printf 'dns_cloudflare_email=${CFUSER}\ndns_cloudflare_api_key=${CFPASSWORD}\n' > /volume/cloudflare.ini ; chmod a-x,go-rw /volume/cloudflare.ini ; mkdir -p /volume/links "
	