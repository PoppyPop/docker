#!/bin/bash
#

docker run -it -v some_volume:/volume -v /tmp:/backup alpine \
    sh -c "rm -rf /volume/* ; tar -C /volume/ -xjf /backup/some_archive.tar.bz2"