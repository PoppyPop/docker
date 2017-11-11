#!/bin/bash
#

docker run --name=bind \
-ti --rm  \
--dns=8.8.8.8 --dns=8.8.4.4 \
-p 1853:53/udp -p 1853:53 \
-v "temp-bind:/etc/bind" \
poppypop/bind $1

# -v "temp-bind:/etc/bind" \
# -v "${PWD}/temp/etc:/etc/bind" \
# -v "${PWD}/temp/cache:/var/cache/bind" \