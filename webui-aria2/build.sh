#!/bin/bash
#

git clone https://github.com/ziahamza/webui-aria2.git
cd webui-aria2

docker build -t poppypop/webui-aria2 .

cd -
