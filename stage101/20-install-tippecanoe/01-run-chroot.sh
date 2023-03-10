#!/bin/bash -e

mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src

if type "tippecanoe" > /dev/null 2>&1; then
  echo "tippecanoe exist!"
  exit 0
fi

cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src
git clone --depth 1 https://github.com/felt/tippecanoe.git
cd ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/src/tippecanoe
make -j LDFLAGS="-latomic"
make install
chmod 777 -R /usr/local/bin
