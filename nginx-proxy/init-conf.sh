#!/bin/bash
#

docker run -it --rm -v ngproxy-tmpl:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/conf/* /volume/"
	
docker run -it --rm -v nsupdate-tmpl:/volume -v ${PWD}/nsupdate:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/* /volume/"
    
docker run -it --rm -v adguard-tmpl:/volume -v ${PWD}/adguard:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/* /volume/"