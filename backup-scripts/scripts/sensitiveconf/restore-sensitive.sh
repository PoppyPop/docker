#!/bin/bash
#

restore_src=$1
archive_name="local-sensitive"
configdir=/opt/poppypop/docker

/srv/scripts/restore-dir.sh $archive_name "$restore_src" "$configdir"