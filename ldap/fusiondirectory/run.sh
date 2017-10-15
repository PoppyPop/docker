#!/bin/bash
#


# docker run -ti --rm -v /srv/datas/ldap/fusiond/fusiondirectory.conf:/etc/fusiondirectory/fusiondirectory.conf --name fusiond -p 12080:80 poppypop/fusiond $1

docker run -ti --rm --name fusiond -p 12080:80 poppypop/fusiond $1
