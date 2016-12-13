image = biobox_testing/gaet

all: ssh

ssh: .image
	docker run \
		--tty \
		--interactive \
		--entrypoint=/bin/bash \
		$(image)

.image: Dockerfile $(shell find image -type f)
	docker build --tag $(image) .
	touch $@
