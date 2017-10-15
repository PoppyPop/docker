#!/bin/sh
#

# limit open file descriptors
ulimit -n 8192

set -e

exec "$@"