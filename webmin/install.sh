#!/bin/bash
#

wget -O- http://www.webmin.com/jcameron-key.asc | sudo apt-key add -

echo 'deb http://download.webmin.com/download/repository sarge contrib' | sudo tee --append /etc/apt/sources.list.d/webmin.list

sudo apt-get update

sudo apt install webmin