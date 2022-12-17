#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" curl -sSL https://get.docker.com | sh
	SUDO_USER="${FIRST_USER_NAME}" groupadd docker
	SUDO_USER="${FIRST_USER_NAME}" usermod -aG docker ${FIRST_USER_NAME}
	SUDO_USER="${FIRST_USER_NAME}" systemctl enable docker.service
	SUDO_USER="${FIRST_USER_NAME}" systemctl enable containerd.service
EOF
