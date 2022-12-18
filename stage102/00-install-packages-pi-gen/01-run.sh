mkdir -p /home/${FIRST_USER_NAME}/src
cd /home/${FIRST_USER_NAME}/src

git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git
git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git

cd ~
