#!/bin/bash -e

mkdir -p /var/www/html
echo "Hello!" > /var/www/html/index.html
chmod 777 -R /var/www/html

install -v -m 644 files/default "${ROOTFS_DIR}/etc/nginx/sites-available/default"
