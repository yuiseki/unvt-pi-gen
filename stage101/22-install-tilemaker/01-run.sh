#!/bin/bash -e

on_chroot << EOF
	mkdir -p /home/${FIRST_USER_NAME}/src
	cd /home/${FIRST_USER_NAME}/src
	git clone --depth 1 https://github.com/systemed/tilemaker.git
	cd /home/${FIRST_USER_NAME}/src/tilemaker
	make -j LDFLAGS="-latomic"
	SUDO_USER="${FIRST_USER_NAME}" make install
	SUDO_USER="${FIRST_USER_NAME}" chmod 777 -R /usr/local/bin/
EOF

ls -alh /usr/local/bin
