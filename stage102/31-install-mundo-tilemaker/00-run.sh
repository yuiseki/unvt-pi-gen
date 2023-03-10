#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" DEBIAN_FRONTEND=noninteractive apt-get install osmctools
EOF

mkdir -p /tmp/osm
mkdir -p /home/${FIRST_USER_NAME}/src

echo $PATH

ls -alh /usr/local/bin

ls -alh /usr/local/bin/tilemaker

if type "tilemaker" > /dev/null 2>&1; then
    echo "tilemaker exist!"
else
    echo "tilemaker NOT exist!"
    exit 1
fi

cd /home/${FIRST_USER_NAME}/src
git clone --depth 1 https://github.com/yuiseki/mundo-tilemaker.git
cd mundo-tilemaker
mkdir -p tmp/osm
cp -r /tmp/osm/* tmp/osm/
rm -rf .env
cp .env.pi .env
make
cp -r tmp/osm/* /tmp/osm/

