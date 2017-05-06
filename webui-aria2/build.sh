#!/bin/bash
#

git clone https://github.com/PoppyPop/aria2-alpine.git

cd aria2-alpine
sudo docker build -t poppypop/aria2:alpine --rm .
cd -
rm -rf aria2-alpine

cd /downloads/aria2/

sudo rm -rf webui-aria2
sudo git clone https://github.com/ziahamza/webui-aria2.git
sudo chown -R download:download /downloads/aria2/webui-aria2

cd -

#cd webui-aria2
#sudo docker build -t poppypop/webui-aria2 --rm .
#cd -
#rm -rf webui-aria2

