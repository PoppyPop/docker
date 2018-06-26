#!/bin/bash
#

docker run -it --rm -v cfssl-data:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/conf/* /volume/"


