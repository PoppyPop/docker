#!/bin/bash
#

docker run -ti --rm --link myelastic:elasticsearch -p 5601:5601 -d --restart=always --name mykibana kibana
