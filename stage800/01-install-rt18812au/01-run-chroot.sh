#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/rtl8812au ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/aircrack-ng/rtl8812au.git
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/rtl8812au
  make dkms_install
fi
