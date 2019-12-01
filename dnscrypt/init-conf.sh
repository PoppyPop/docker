#!/bin/bash
#

docker run -it --rm -v dnscrypt-datas:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/conf/* /volume/"
	