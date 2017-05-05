#!/bin/bash
#

sudo apt-get install unar

sudo mkdir -p /srv/aria2/Downloads
sudo mkdir -p /srv/aria2/Extract
sudo mkdir -p /srv/aria2/Ended
sudo mkdir -p /srv/aria2/webui-aria2

sudo cp ./ /srv/aria2/
sudo cp ./ /srv/aria2/

sudo useradd -m download
sudo chown -R download:download /srv/aria2/

sudo id download
