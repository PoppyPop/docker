#!/bin/bash
#

#confs
sudo mkdir -p /srv/confs/cfssl

sudo cp -f docker-compose.yml /srv/confs/cfssl/

#datas
docker volume create cfssl-data --label backup=yes

#backs
sudo mkdir -p /srv/backs/cfssl

# clean data
# docker run -it --rm -v cfssl-data:/volume alpine  sh -c "rm -rf /volume/* "