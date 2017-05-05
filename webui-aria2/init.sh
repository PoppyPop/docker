#!/bin/bash
#

sudo apt-get install unar

sudo mkdir -p /srv/aria2/Downloads
sudo mkdir -p /srv/aria2/Extract
sudo mkdir -p /srv/aria2/Ended

sudo cp ./autounrar.py /srv/aria2/autounrar.py
sudo cp ./copyFile.sh /srv/aria2/copyFile.sh

sudo useradd -m download
sudo chown -R download:download /srv/aria2/

sudo id download
