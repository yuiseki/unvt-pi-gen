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

- Raspberry Pi 4 Model B
  - Default Raspbian (32-bit)

```bash
sudo apt install make
```

## Usage

```bash
git clone git@github.com:yuiseki/unvt-pi-gen.git
cd unvt-pi-gen
cp .env.example .env
vim .env
make docker-setup
make docker-build
make unvt-pi-gen
```
