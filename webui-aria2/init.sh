#!/bin/bash
#

sudo apt-get install unar

sudo mkdir -P /srv/aria2/Downloads
sudo mkdir -P /srv/aria2/Extract
sudo mkdir -P /srv/aria2/Ended

sudo cp ./ /srv/aria2/
sudo cp ./ /srv/aria2/

sudo useradd -m download
sudo chown -R download:download /srv/aria2/

sudo id download