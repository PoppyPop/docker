#!/bin/bash
#

sudo apt-get install unar nfs-common

sudo mkdir -p /srv/aria2/Downloads
sudo mkdir -p /srv/aria2/Extract
sudo mkdir -p /srv/aria2/Ended
sudo mkdir -p /srv/aria2/webui-aria2

sudo cp -f autounrar.py /srv/aria2/
sudo cp -f copyFile.sh /srv/aria2/
sudo cp -f complete.sh /srv/aria2/Downloads/

#conf
sudo mkdir -p /srv/confs/aria2/
sudo cp -f docker-compose.yml /srv/confs/aria2/

#sudo
sudo cp -f download-sudo /etc/sudoers.d/

sudo useradd -m download
sudo chown -R download:download /srv/aria2/

sudo id download
