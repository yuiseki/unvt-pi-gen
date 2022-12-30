FROM pinto0309/raspios_lite_armhf:2022-06-16_bullseye

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install \
  coreutils \
  sudo \
  curl \
  git \
  vim \
  grep \
  build-essential \
  jq \
  make


RUN apt-get -y install \
  bc \
  file \
  rsync \
  quilt \
  zip \
  xz-utils \
  gpg \
  pigz


RUN apt-get -y install \
  parted \
  qemu-user-static \
  qemu-utils \
  debootstrap \
  zerofree \
  dosfstools \
  libarchive-tools \
  libcap2-bin \
  kpartx \
  kmod


RUN apt-get -y install clang


WORKDIR /app

RUN git clone --depth 1 https://github.com/RPI-Distro/pi-gen.git

WORKDIR /app/pi-gen

CMD ["/bin/bash"]
