#!/bin/bash
#

sudo cp -rf shutserver.py /srv/

sudo cp -f shutserver.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable shutserver.service
