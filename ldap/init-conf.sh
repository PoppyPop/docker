#!/bin/bash
#

docker run -it --rm -v fusiond-config:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/fusiondirectory/fusiondirectory.conf /volume/"


