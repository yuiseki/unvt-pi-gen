# unvt-pi-gen

## Summary

- What
  - Dockerfile and Makefile for building a customized Raspberry Pi OS image
- Why
  - To quickly deploy a Raspberry Pi configured for a specific purpose
- How
  - Build a customized Raspberry Pi OS image using `pi-gen`
    - https://github.com/RPi-Distro/pi-gen

## Requirements

### MUST:

- Linux OS
  - WSL2
  - Ubuntu
  - Raspberry Pi 4 Model B
    - Raspberry Pi OS Lite (64-bit)
- Common requirements
  - GNU Make
  - Docker

### GNU Make

```bash
sudo apt install make
```

### QEMU

```bash
sudo apt install qemu binfmt-support qemu-user-static
```

### SHOULD:

- vim (or any text editor)

## Usage

### 1. Clone repository

```bash
git clone --depth 1 https://github.com/yuiseki/unvt-pi-gen.git
cd unvt-pi-gen
```

### 2. Initialize `.env`

```bash
cp .env.example .env
vim .env
```

### 3. Setup docker (if necessary)

```bash
make docker-setup
```

### 4. Build docker image for pi-gen

```bash
make docker-build
```

### 5. Build Raspberry Pi OS

```bash
make
```

NOTE: When Rebuild the OS image, run following commands:

```bash
make clean
make clean-all
```

### 6. Write to microSD Card

```bash
df -h
sudo umount /dev/sda1
sudo umount /dev/sda2
df -h
sudo dd if=tmp/deploy/YYYY-mm-dd-IMG_NAME-custom.img of=/dev/sda bs=4M conv=fsync status=progress
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

- **stage100** - Essential stage. Install must essential dev deps packages.
- **stage200** - Docker stage. Install Docker for Raspberry Pi OS.
- **stage999** - **Not used.**
