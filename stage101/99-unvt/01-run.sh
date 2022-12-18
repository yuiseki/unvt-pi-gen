#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/charites ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/unvt/charites.git
fi

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/vector-tile-builder ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/vector-tile-builder.git
fi

#on_chroot << EOF
#  cd /home/${FIRST_USER_NAME}/src/vector-tile-builder && docker build . -t yuiseki/vector-tile-builder:latest
#EOF
