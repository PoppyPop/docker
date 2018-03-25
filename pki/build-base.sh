#!/bin/bash
#

git clone https://github.com/cloudflare/cfssl.git

docker build -t cfssl/cfssl -f cfssl/Dockerfile.minimal cfssl

rm -rf cfssl
