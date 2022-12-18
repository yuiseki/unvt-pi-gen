include .env

targets = \
	docker-build \
	unvt-pi-gen

all: $(targets)

clean:
	sudo rm -rf $(CURDIR)/tmp/deploy/*
	sudo rm -rf $(CURDIR)/tmp/work/stage10*

.PHONY: docker-setup
docker-setup:
	curl -fsSL https://get.docker.com -o $(CURDIR)/tmp/get-docker.sh
	sudo sh $(CURDIR)/tmp/get-docker.sh
	sudo chmod 666 /var/run/docker.sock
	sudo chgrp docker /var/run/docker.sock
	sudo gpasswd -a pi docker

.PHONY: docker-build
docker-build:
	docker image inspect sameersbn/apt-cacher-ng:latest > /dev/null || docker build -t sameersbn/apt-cacher-ng:latest github.com/sameersbn/docker-apt-cacher-ng
	docker image inspect yuiseki/unvt-pi-gen:latest > /dev/null || docker build . -t yuiseki/unvt-pi-gen:latest

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
	--mount type=bind,source=$(CURDIR)/stage101,target=/app/pi-gen/stage101 \
	--mount type=bind,source=$(CURDIR)/stage102,target=/app/pi-gen/stage102 \
	--net=unvt-pi-gen \
	--env-file $(CURDIR)/.env \
	-e APT_PROXY=http://unvt-pi-gen:3142 \
	-e IMG_NAME=unvt-pi \
	-e WORK_DIR=/tmp/work \
	-e DEPLOY_DIR=/tmp/deploy \
	-e CONTINUE=1 \
	-e DEBIAN_FRONTEND=noninteractive \
	-e STAGE_LIST="stage0 stage1 stage2 stage100 stage101 stage102" \
	yuiseki/unvt-pi-gen \
		bash -c "touch ./stage2/SKIP_IMAGES && ./build.sh"
	docker compose down
