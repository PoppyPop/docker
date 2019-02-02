#!/bin/bash
#

docker run -it --rm -v ngproxy-vhost:/volume -v ${PWD}:/orig alpine \
    sh -c "cp -fa /orig/vhost/cloud.mo-ot.fr /volume/"
	