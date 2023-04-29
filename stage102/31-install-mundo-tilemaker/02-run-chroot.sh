#!/bin/bash -e

ls -alh /usr/local/bin
ls -alh /home/${FIRST_USER_NAME}/tmp

if type "tilemaker" > /dev/null 2>&1; then
    echo "tilemaker exist!"
else
    echo "tilemaker NOT exist!"
    exit 1
fi

mkdir -p /home/${FIRST_USER_NAME}/src

cd /home/${FIRST_USER_NAME}/src
git clone --depth 1 https://github.com/yuiseki/mundo-tilemaker.git
cp tilemaker/config.json mundo-tilemaker
cp tilemaker/process.lua mundo-tilemaker
cd mundo-tilemaker
cp -r /home/${FIRST_USER_NAME}/tmp/* ./tmp

cp .env.pi .env
make
