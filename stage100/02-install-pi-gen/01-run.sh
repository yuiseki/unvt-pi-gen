#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/pi-gen ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git
fi

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/unvt-pi-gen ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
fi
