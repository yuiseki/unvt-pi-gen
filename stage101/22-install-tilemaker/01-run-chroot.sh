#!/bin/bash -e

mkdir -p /home/${FIRST_USER_NAME}/src

if type "tilemaker" > /dev/null 2>&1; then
  echo "tilemaker exist!"
  exit 0
fi

cd /home/${FIRST_USER_NAME}/src

git clone --depth 1 https://github.com/systemed/tilemaker.git
cd /home/${FIRST_USER_NAME}/src/tilemaker
make -j LDFLAGS="-latomic"
make install

mkdir -p /usr/local/bin/
ls -alh /usr/local/bin
