#!/bin/bash
#

docker run -it --rm -v elastic1-datas:/volume -v /srv/datas/efk/elastic1:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/* /volume/"

docker run -it --rm -v elastic2-datas:/volume -v /srv/datas/efk/elastic2:/orig alpine \
    sh -c "rm -rf /volume/* ; cp -fa /orig/* /volume/"