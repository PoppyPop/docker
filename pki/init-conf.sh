#!/bin/bash
#

docker run --rm -v cfssl-data:/volume -v ${PWD}:/orig alpine \
    sh -c "cp -fa /orig/conf/* /volume/"


