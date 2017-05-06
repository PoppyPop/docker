#!/bin/bash
#

sudo apt-get install unar nfs-common

sudo mkdir -p /downloads/aria2/Downloads
sudo mkdir -p /downloads/aria2/Extract
sudo mkdir -p /downloads/aria2/Ended
sudo mkdir -p /downloads/aria2/webui-aria2

sudo cp -f autounrar.py /downloads/aria2/
sudo cp -f copyFile.sh /downloads/aria2/
sudo cp -f complete.sh /downloads/aria2/Downloads/

#conf
sudo mkdir -p /srv/confs/aria2/
sudo cp -f docker-compose.yml /srv/confs/aria2/

#sudo
sudo cp -f download-sudo /etc/sudoers.d/

sudo useradd -m download
sudo chown -R download:download /downloads/aria2/

sudo id download
