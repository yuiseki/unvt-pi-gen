include .env

targets = \
	docker-build \
	unvt-pi-gen

all: $(targets)

clean:
	sudo rm -rf $(CURDIR)/tmp/work/stage30*

clean-all:
	sudo rm -rf $(CURDIR)/tmp/work/stage10*
	sudo rm -rf $(CURDIR)/tmp/work/stage20*
	sudo rm -rf $(CURDIR)/tmp/work/stage30*
	sudo rm -rf $(CURDIR)/tmp/deploy/*
	sudo rm -rf $(CURDIR)/tmp/work/*

clean-root:
	rm root-armhf.tar.xz
	rm root-arm64.tar.xz

.PHONY: docker-setup
docker-setup:
	command -v docker
	curl -fsSL https://get.docker.com -o $(CURDIR)/tmp/get-docker.sh
	sudo sh $(CURDIR)/tmp/get-docker.sh
	sudo usermod -aG docker $(whoami)

root-arm64.tar.xz:
	curl -SL https://downloads.raspberrypi.org/raspios_lite_arm64/root.tar.xz -o root-arm64.tar.xz

root-armhf.tar.xz:
	curl -SL https://downloads.raspberrypi.org/raspios_lite_armhf/root.tar.xz -o root-armhf.tar.xz

.PHONY: docker-build
docker-build: root-arm64.tar.xz root-armhf.tar.xz
	docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
	docker image inspect sameersbn/apt-cacher-ng:latest > /dev/null || docker build -t sameersbn/apt-cacher-ng:latest github.com/sameersbn/docker-apt-cacher-ng
	docker image inspect yuiseki/unvt-pi-gen-arm64:latest > /dev/null || docker build . -f Docker/Dockerfile.arm64 -t yuiseki/unvt-pi-gen-arm64:latest
	docker image inspect yuiseki/unvt-pi-gen-armhf:latest > /dev/null || docker build . -f Docker/Dockerfile.armhf -t yuiseki/unvt-pi-gen-armhf:latest

.PHONY: unvt-pi-gen
unvt-pi-gen:
	docker compose up -d
	docker run \
	-i \
	--rm \
	--privileged \
	--cap-add=ALL \
	-v /dev:/dev \
	-v /lib/modules:/lib/modules \
	--mount type=bind,source=$(CURDIR)/tmp,target=/tmp \
	--mount type=bind,source=$(CURDIR)/stage100,target=/app/pi-gen/stage100 \
	--mount type=bind,source=$(CURDIR)/stage200,target=/app/pi-gen/stage200 \
	--mount type=bind,source=$(CURDIR)/stage300,target=/app/pi-gen/stage300 \
	--net=unvt-pi-gen \
	--env-file $(CURDIR)/.env \
	--name unvt-pi-gen \
	-e CONTINUE=1 \
	-e DEBIAN_FRONTEND=noninteractive \
	-e STAGE_LIST="stage0 stage1 stage2 stage100 stage200 stage300" \
	yuiseki/unvt-pi-gen-arm64 bash -e -o pipefail -c "\
		dpkg-reconfigure qemu-user-static &&\
		(mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc || true) &&\
			touch ./stage0/SKIP_IMAGES &&\
			touch ./stage1/SKIP_IMAGES &&\
			touch ./stage2/SKIP_IMAGES &&\
		./build.sh\
	"
#	yuiseki/unvt-pi-gen-arm64 bash -e -o pipefail -c "\
#			dpkg-reconfigure qemu-user-static &&\
#			(mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc || true) &&\
#			touch ./stage0/SKIP &&\
#			touch ./stage0/SKIP_IMAGES &&\
#			touch ./stage1/SKIP &&\
#			touch ./stage1/SKIP_IMAGES &&\
#			touch ./stage2/SKIP &&\
#			touch ./stage2/SKIP_IMAGES &&\
#			touch ./stage100/SKIP &&\
#			touch ./stage200/SKIP &&\
#			./build.sh\
#		"
	docker compose down

.PHONY: kill
kill:
	docker stop unvt-pi-gen
