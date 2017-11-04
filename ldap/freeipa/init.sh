#!/bin/bash
#

#confs
#sudo mkdir -p /srv/confs/ldap

#sudo cp -f docker-compose.yml /srv/confs/ldap/

#datas
docker volume create freeipa-data --label backup=yes

docker run -it --rm -v freeipa-data:/volume --mount type=bind,source="$(pwd)",target=/local alpine \
    sh -c "rm -rf /volume/* ; cp /local/ipa-server-install-options /volume"

#backs
#sudo mkdir -p /srv/backs/ldap
