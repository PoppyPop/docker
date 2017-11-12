#!/bin/bash
#

#docker run -ti --rm poppypop/cfssl /bin/sh

docker run -ti --rm -v cfssl-data:/etc/cfssl poppypop/cfssl /bin/sh
