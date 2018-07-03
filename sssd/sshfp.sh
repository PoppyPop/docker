#!/bin/bash
#

AUTOORGURL=$(curl -L -s -u "PoppyPop" https://api.github.com/repos/PoppyPop/go-sshfp-pdns/releases/latest | jq -r ".assets[] | select(.name | test(\"sshfp-pdns_linux_amd64\")) | .browser_download_url")

curl -L -s $AUTOORGURL > sshfp-pdns

sudo chmod +x sshfp-pdns