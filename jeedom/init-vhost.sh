#!/bin/bash
#

docker run -it --rm -v ngproxy-vhost:/volume -v ${PWD}:/orig alpine \
    sh -c "cp -fa /orig/vhost/jeedom.mo-ot.fr_location /volume/"
	