#!/bin/bash
#

# Fail on error
set -e

AUTOORGURL=$(curl -L -s -u "PoppyPop" https://api.github.com/repos/PoppyPop/Emby.AutoOrganize/releases/latest | jq -r ".assets[] | select(.name | test(\"Emby.AutoOrganize.dll\")) | .browser_download_url")

curl -L -s $AUTOORGURL > Emby.AutoOrganize.dll

docker run --rm  -v emby-datas:/dist -v ${PWD}:/local alpine \
	sh -c 'mkdir -p /dist/plugins/ && cp -f /local/Emby.AutoOrganize.dll /dist/plugins/Emby.AutoOrganize.dll'
	
AUTOORGURL=$(curl -L -s -u "PoppyPop" https://api.github.com/repos/PoppyPop/Emby.addic7ed/releases/latest | jq -r ".assets[] | select(.name | test(\"Emby.addic7ed.dll\")) | .browser_download_url")

curl -L -s $AUTOORGURL > Emby.addic7ed.dll	

docker run --rm  -v emby-datas:/dist -v ${PWD}:/local alpine \
	sh -c 'mkdir -p /dist/plugins/ && cp -f /local/Emby.addic7ed.dll /dist/plugins/Emby.addic7ed.dll'
	
rm Emby.addic7ed.dll Emby.AutoOrganize.dll
	
