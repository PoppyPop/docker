#!/bin/bash
#

docker run -it --rm -v trakt-datas:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/AutoDl.db /volume/ "
	
	