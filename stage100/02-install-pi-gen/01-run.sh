mkdir -p /home/${FIRST_USER_NAME}/src
cd /home/${FIRST_USER_NAME}/src

if [ ! -d ~/src/pi-gen ]; then
  git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git
fi

if [ ! -d ~/src/unvt-pi-gen ]; then
  git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
fi

cd ~
