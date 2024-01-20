#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if [ ! -d ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/unvt-pi-gen ]; then
  cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
  git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
fi

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" chmod 755 -R /home/${FIRST_USER_NAME}/src
	SUDO_USER="${FIRST_USER_NAME}" chown ${FIRST_USER_NAME}:${FIRST_USER_NAME} -R /home/${FIRST_USER_NAME}/src
EOF
