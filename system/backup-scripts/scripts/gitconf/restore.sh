#!/bin/bash
#

# Restore volume
find /opt/poppypop/docker/ -name 'volumes.sh' -exec echo "Executing {}" \; -execdir bash {} \;

# Restore network
find /opt/poppypop/docker/ -name 'networks.sh' -exec echo "Executing {}" \; -execdir bash {} \;

# Restore init
find /opt/poppypop/docker/ -name 'init.sh' -exec echo "Executing {}" \; -execdir bash {} \;

# Restore Conf
find /opt/poppypop/docker/ -name 'init-*.sh' -exec echo "Executing {}" \; -execdir bash {} \;