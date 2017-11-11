#!/bin/bash
#

docker run -ti --rm -p 88:88 -p 749:749 -p 464:464 -p 750:750 --name krb poppypop/krb $1
