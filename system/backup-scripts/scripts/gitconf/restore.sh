#!/bin/bash
#

# Restore volume
find /opt/poppypop/docker/ -name 'volumes.sh' -exec sh {} \;

# Restore network
find /opt/poppypop/docker/ -name 'networks.sh' -exec sh {} \;

# Restore init
find /opt/poppypop/docker/ -name 'init.sh' -exec sh {} \;

# Restore Conf
find /opt/poppypop/docker/ -name 'init-*.sh' -exec sh {} \;