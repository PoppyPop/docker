#!/bin/bash
#

# Fail on error
set -e

docker run --rm  -v emby-datas:/dist -v ${PWD}:/local alpine \
	cp -f /local/Emby.AutoOrganize.dll /dist/plugins/Emby.AutoOrganize.dll
	
