#!/bin/bash
#

docker run -it --rm -v pdns-lua-conf:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/conf/* /volume/"
	