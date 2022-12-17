include .env

targets = \
	docker-build \
	unvt-pi-gen

all: $(targets)

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
	--mount type=bind,source=$(CURDIR)/stage99,target=/app/pi-gen/stage99 \
	--net=unvt-pi-gen \
	--env-file ./.env \
	-e APT_PROXY=http://172.17.0.1:3142 \
	-e IMG_NAME=unvt-pi \
	-e WORK_DIR=/tmp/work \
	-e DEPLOY_DIR=/tmp/deploy \
	-e CONTINUE=1 \
	-e DEBIAN_FRONTEND=noninteractive \
	yuiseki/unvt-pi-gen \
		bash -c "\
			touch ./stage3/SKIP ./stage4/SKIP ./stage5/SKIP && \
			touch ./stage4/SKIP_IMAGES ./stage5/SKIP_IMAGES && \
			./build.sh \
		"
	docker compose down
