#!/bin/bash -e

mkdir -p /home/${FIRST_USER_NAME}/src

if type "tippecanoe" > /dev/null 2>&1; then
  echo "tippecanoe exist!"
  exit 0
fi

cd /home/${FIRST_USER_NAME}/src
git clone --depth 1 https://github.com/felt/tippecanoe.git
cd /home/${FIRST_USER_NAME}/src/tippecanoe
make -j LDFLAGS="-latomic"
make install

ls -alh /usr/local/bin
