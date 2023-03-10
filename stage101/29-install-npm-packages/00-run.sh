#!/bin/bash -e

# Reuse npm cache
cp -rf /tmp/.npm ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/

npm install -g http-server
npm install -g mbtiles2tilejson
npm install -g osmtogeojson
npm install -g geojson2poly
npm install -g charites

# Persistent npm cache
cp -r ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/.npm /tmp/

chmod -R 777 /tmp/.npm
