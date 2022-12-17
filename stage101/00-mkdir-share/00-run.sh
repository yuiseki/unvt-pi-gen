#!/bin/bash -e

on_chroot << EOF
	mkdir -p "/home/share"
	echo "Hello!" > /home/share/index.html
	chmod 777 -R /home/share
EOF
