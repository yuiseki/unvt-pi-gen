#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if type "tilemaker" > /dev/null 2>&1; then
  echo "tilemaker exist!"
  exit 0
fi

cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

git clone --depth 1 https://github.com/systemed/tilemaker.git
cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tilemaker
make -j LDFLAGS="-latomic"
make install
chmod 777 -R /usr/local/bin
