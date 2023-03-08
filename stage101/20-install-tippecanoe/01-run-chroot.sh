#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tippecanoe ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/felt/tippecanoe.git
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tippecanoe
  make -j LDFLAGS="-latomic"; make install
fi
