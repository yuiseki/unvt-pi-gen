#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tilemaker ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/systemed/tilemaker.git
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tilemaker
  make -j LDFLAGS="-latomic"; make install
fi

chmod 777 -R ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
chown ${FIRST_USER_NAME}:${FIRST_USER_NAME} -R ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/
