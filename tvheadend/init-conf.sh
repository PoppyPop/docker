#!/bin/bash
#

docker run -it --rm -v tvheadend-config:/volume -v ${PWD}:/orig alpine \
    sh -c "cp -fa /orig/cron.sh /volume/"


	