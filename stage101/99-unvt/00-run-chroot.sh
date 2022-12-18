#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/charites ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/unvt/charites.git
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/charites
  npm ci; npm run build; npm install -g .
fi
