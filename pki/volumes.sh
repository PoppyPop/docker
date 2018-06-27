#!/bin/bash
#

#datas
docker volume create cfssl-data --label backup=yes

# clean data
# docker run -it --rm -v cfssl-data:/volume alpine  sh -c "rm -rf /volume/* "
