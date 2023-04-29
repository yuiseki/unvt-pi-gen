#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/var/www/html
echo "Hello!" > ${ROOTFS_DIR}/var/www/html/index.html
chmod 777 -R ${ROOTFS_DIR}/var/www/html

install -v -m 644 files/default "${ROOTFS_DIR}/etc/nginx/sites-available/default"
