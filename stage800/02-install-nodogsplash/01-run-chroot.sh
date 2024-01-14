#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/nodogsplash ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/nodogsplash/nodogsplash.git
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/nodogsplash
  make -j3
  make install
fi
