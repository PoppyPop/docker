#!/bin/bash
#

docker run -it --rm -v web-conf:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/nginx/* /volume/ ; cp -fa /orig/varnish/default.vcl /volume/"
	
	