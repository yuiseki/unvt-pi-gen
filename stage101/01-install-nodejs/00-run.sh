#!/bin/bash -e

on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" command node > /dev/null || curl -Ls https://deb.nodesource.com/setup_18.x | bash
EOF
