include .env

targets = \
	docker-build \
	unvt-pi-gen

all: $(targets)

clean:
	sudo rm -rf $(CURDIR)/tmp/work/stage10*

clean-all:
	sudo rm -rf $(CURDIR)/tmp/deploy/*
	sudo rm -rf $(CURDIR)/tmp/work/*

.PHONY: docker-setup
docker-setup:
	curl -fsSL https://get.docker.com -o $(CURDIR)/tmp/get-docker.sh
	sudo sh $(CURDIR)/tmp/get-docker.sh
	sudo usermod -aG docker $(whoami)

.PHONY: docker-build
docker-build:
	docker image inspect sameersbn/apt-cacher-ng:latest > /dev/null || docker build -t sameersbn/apt-cacher-ng:latest github.com/sameersbn/docker-apt-cacher-ng
	docker image inspect yuiseki/unvt-pi-gen:2022-06-16_bullseye > /dev/null || docker build . -t yuiseki/unvt-pi-gen:2022-06-16_bullseye

# For skip...
# touch ./stage0/SKIP ./stage1/SKIP ./stage2/SKIP &&
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
	--net=unvt-pi-gen \
	--env-file $(CURDIR)/.env \
	-e APT_PROXY=http://apt-cacher-ng:3142 \
	-e WORK_DIR=/tmp/work \
	-e DEPLOY_DIR=/tmp/deploy \
	-e CONTINUE=1 \
	-e DEBIAN_FRONTEND=noninteractive \
	-e STAGE_LIST="stage0 stage1 stage2 stage100 stage101" \
	yuiseki/unvt-pi-gen:2022-06-16_bullseye \
		bash -c "\
			touch ./stage2/SKIP_IMAGES &&\
		 ./build.sh\
		 "
	docker compose down
