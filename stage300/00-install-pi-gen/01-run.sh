#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/pi-gen ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 --branch master --single-branch https://github.com/RPI-Distro/pi-gen.git
  cd pi-gen
  for branch in arm64; do
      git fetch origin $branch:$branch
  done
fi

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/unvt-pi-gen ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
fi

#on_chroot << EOF
#  cd /home/${FIRST_USER_NAME}/src/unvt-pi-gen && docker build . -t yuiseki/unvt-pi-gen:latest
#EOF
