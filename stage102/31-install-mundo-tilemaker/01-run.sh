
ls -alh /tmp/osm
mkdir -p ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/tmp/osm
cp -r /tmp/osm/* ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/tmp/osm
ls -alh ${ROOTFS_DIR}/home/${FIRST_USER_NAME}/tmp
