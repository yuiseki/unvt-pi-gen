#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" curl -Ls https://deb.nodesource.com/setup_18.x | bash
EOF
