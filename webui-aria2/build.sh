#!/bin/bash
#

git clone https://github.com/PoppyPop/aria2-alpine.git

cd aria2-alpine
sudo docker build -t poppypop/aria2:alpine --rm .
cd -
rm -rf aria2-alpine

git clone https://github.com/ziahamza/webui-aria2.git


cd webui-aria2
sudo docker build -t poppypop/webui-aria2 --rm .
cd -
rm -rf webui-aria2


sudo mkdir /srv/webui-aria2
sudo mkdir /srv/webui-aria2/Downloads
