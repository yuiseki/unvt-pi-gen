#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/mundo-maps ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/mundo-maps.git
    cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/mundo-maps
  npm ci; npm run build
fi
