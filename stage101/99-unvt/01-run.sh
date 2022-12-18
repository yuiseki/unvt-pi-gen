mkdir -p /home/${FIRST_USER_NAME}/src
cd /home/${FIRST_USER_NAME}/src

if [ ! -d ~/src/charites ]; then
  git clone --depth 1 https://github.com/unvt/charites.git
fi

if [ ! -d ~/src/vector-tile-builder ]; then
  git clone --depth 1 https://github.com/yuiseki/vector-tile-builder.git
fi

cd ~
