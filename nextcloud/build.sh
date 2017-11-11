#!/bin/bash
#

cd app

docker build -t poppypop/nextcloud-app --rm -f Dockerfile  .

cd -

cd web

docker build -t poppypop/nextcloud-web --rm -f Dockerfile  .

cd -