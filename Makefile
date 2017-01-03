image = biobox_testing/gaet

all: ssh

ssh: .image
	docker run \
		--tty \
		--interactive \
		--volume=$(shell pwd)/tmp/input:/bbx/input:ro \
		--volume=$(shell pwd)/tmp/output:/bbx/output:rw \
		--entrypoint=/bin/bash \
		$(image)

.image: Dockerfile $(shell find image -type f)
	docker build --tag $(image) .
	touch $@
