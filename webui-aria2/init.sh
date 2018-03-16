#!/bin/bash
#

sudo apt-get install unar nfs-common

sudo mkdir -p /datas/downloads/aria2/datas/Downloads
sudo mkdir -p /datas/downloads/aria2/datas/Extract
sudo mkdir -p /datas/downloads/aria2/datas/Ended
sudo mkdir -p /datas/downloads/aria2/webui-aria2

sudo cp -f autounrar.py /datas/downloads/aria2/datas/
sudo cp -f copyFile.sh /datas/downloads/aria2/datas/
sudo cp -f complete.sh /datas/downloads/aria2/datas/

#conf
sudo mkdir -p /srv/confs/aria2/
sudo cp -f docker-compose.yml /srv/confs/aria2/

#sudo
sudo cp -f download-sudo /etc/sudoers.d/

sudo useradd -m download
sudo chown -R download:download /datas/downloads/aria2/

setfacl -d -R -m g:domain_media:rwX /datas/downloads/aria2/
setfacl -R -m g:domain_media:rwX /datas/downloads/aria2/

sudo id download
