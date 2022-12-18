# unvt-pi-gen

## Summary

- What
  - Dockerfile and Makefile for building a customized Raspberry Pi OS image
- Why
  - To quickly deploy a Raspberry Pi configured for a specific purpose
- How
  - Build a customized Raspberry Pi OS image using `pi-gen`
    - https://github.com/RPi-Distro/pi-gen

## Dependencies

### MUST:

- Raspberry Pi 4 Model B
  - Raspberry Pi OS Lite (32-bit)
- GNU Make

```bash
sudo apt install make
```

### SHOULD:

- Docker
- vim

## Usage

### Clone repository

```bash
git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
cd unvt-pi-gen
```

### Initialize `.env`

```bash
cp .env.example .env
vim .env
```

### Setup docker (if necessary)

```bash
make docker-setup
```

### Build Raspbery Pi OS

```bash
make
```

### Write to microSD Card

```bash
df -h
sudo umount /dev/sda
df -h
sudo dd if=tmp/work/export-image/YYYY-mm-dd-unvt-pi-custom.img of=/dev/sda bs=4M conv=fsync status=progress
```

## Stage Anatomy

### `pi-gen` Stage Overview

  - **stage0** - Run the original `pi-gen` as-is.
  - **stage1** - Run the original `pi-gen` as-is.
  - **stage2** - Run the original `pi-gen` as-is.
  - **stage3** - **Skipped.**
  - **stage4** - **Skipped.**
  - **stage5** - **Skipped.**

### `unvt-pi-gen` Stage Overview

  - **stage100** - Essential stage. Install must essential dev deps packages, setup the Docker and `unvt-pi-gen` itself.
    This means you can take the next stage as many times as you like by trial and error. 
  - **stage101** - Customizing stage. Install GIS related packages, Node.js and Setup Nginx.
  - **stage999** - **Not used.**
