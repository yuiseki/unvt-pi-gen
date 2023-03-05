#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" DEBIAN_FRONTEND=noninteractive apt-get install osmctools
EOF

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/mundo-tilemaker ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/mundo-tilemaker.git
  cd mundo-tilemaker
  mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/mundo-tilemaker/tmp/osm
  cp -r /tmp/osm/* ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/mundo-tilemaker/tmp/osm/
  rm -rf .env
  cp .env.pi .env
  make
  cp -r ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/mundo-tilemaker/tmp/osm/* /tmp/osm/
fi
