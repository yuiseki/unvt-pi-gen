#!/bin/bash -e

mkdir -p /home/${FIRST_USER_NAME}/src

cd /home/${FIRST_USER_NAME}/src
git clone --depth 1 https://github.com/yuiseki/mundo-maps.git
cd /home/${FIRST_USER_NAME}/src/mundo-maps
npm ci
npm run build
