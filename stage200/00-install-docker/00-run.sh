#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" DEBIAN_FRONTEND=noninteractive apt-get update -qq > /dev/null
	SUDO_USER="${FIRST_USER_NAME}" DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
	SUDO_USER="${FIRST_USER_NAME}" command -v docker > /dev/null || curl -sSL https://get.docker.com | sh
	SUDO_USER="${FIRST_USER_NAME}" usermod -aG docker ${FIRST_USER_NAME}
	SUDO_USER="${FIRST_USER_NAME}" systemctl enable docker.service
	SUDO_USER="${FIRST_USER_NAME}" systemctl enable containerd.service
EOF
