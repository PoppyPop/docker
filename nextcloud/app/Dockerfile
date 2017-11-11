FROM nextcloud:fpm

RUN apt-get update && apt-get install -y smbclient && rm -rf /var/lib/apt/lists/*

COPY redis.config.php /usr/src/nextcloud/config/redis.config.php
