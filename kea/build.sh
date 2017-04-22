#!/bin/bash
#

git clone https://github.com/PoppyPop/docker-kea.git

cd docker-kea
sudo docker build -t poppypop/kea --rm .
cd - 
rm -rf docker-kea
