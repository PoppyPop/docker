#!/bin/bash
#

src=${BASH_SOURCE%/*}

curator --config ${src}/config.yml ${src}/backup.yml

