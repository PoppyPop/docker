#!/bin/bash
#

docker run -it --rm -v fluent-conf:/volume -v ${PWD}:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/fluentd/fluent.conf /volume/"