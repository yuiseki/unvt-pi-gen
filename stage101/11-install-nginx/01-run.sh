#!/bin/bash -e

install -v -m 644 files/default "${ROOTFS_DIR}/etc/nginx/sites-available/default"
