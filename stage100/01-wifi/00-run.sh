#!/bin/bash -e

if [ -v WPA_ESSID ] && [ -v WPA_PASSWORD ]; then
on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" /usr/lib/raspberrypi-sys-mods/imager_custom set_wlan $WPA_ESSID $WPA_PASSWORD $WPA_COUNTRY
	SUDO_USER="${FIRST_USER_NAME}" cat /etc/NetworkManager/system-connections/preconfigured.nmconnection
EOF
fi
