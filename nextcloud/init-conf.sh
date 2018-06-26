#!/bin/bash
#

docker run -it --rm -v nextcloud-config:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/redis.config.php ; cp -fa /orig/conf/redis.config.php /volume/"


docker run -it --rm -v nextcloud-nginx:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/conf/nginx.conf /volume/"
	