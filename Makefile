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
	docker image inspect yuiseki/unvt-pi-gen:latest > /dev/null || docker build . -t yuiseki/unvt-pi-gen:latest

.PHONY: unvt-pi-gen
unvt-pi-gen:
	docker run \
	-i \
	--rm \
	--mount type=bind,source=$(CURDIR)/tmp,target=/tmp \
	--env-file ./.env \
	-e IMG_NAME=unvt-pi \
	-e DEPLOY_DIR=/tmp \
	--privileged \
	yuiseki/unvt-pi-gen \
		./build.sh
