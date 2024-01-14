#!/bin/bash -e

# Restore npm cache
mkdir -p /tmp/.npm
cp -rf /tmp/.npm ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

on_chroot << EOF
	npm install -g http-server
	npm install -g mbtiles2tilejson
	npm install -g osmtogeojson
	npm install -g geojson2poly
	npm install -g charites
EOF

# Persistent npm cache
cp -r ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.npm /tmp/
