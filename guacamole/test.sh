#!/bin/sh
#

docker run --name guacd -d guacamole/guacd

docker run --name some-guacamole \
    --link guacd:guacd        \
    ...
    -d -p 8080:8080 guacamole/guacamole