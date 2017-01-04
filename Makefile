path        = PATH=$(abspath ./vendor/python/bin):${PATH}
image       = biobox_testing/gaet
cli_version = 0.5.2

all: ssh

test: .image vendor/python tmp
	TMPDIR=$(abspath tmp) $(path) \
	       biobox verify assembler_benchmark $(image) --verbose

ssh: .image
	docker run \
		--tty \
		--interactive \
		--volume=$(shell pwd)/tmp/input:/bbx/input:ro \
		--volume=$(shell pwd)/tmp/output:/bbx/output:rw \
		--entrypoint=/bin/bash \
		$(image)


.image: $(shell find image -type f )
	@docker build --tag $(image) .
	@touch $@

bootstrap: vendor/python tmp

tmp:
	@mkdir -p tmp

vendor/python:
	@mkdir -p log
	@virtualenv $@ 2>&1 > log/virtualenv.txt
	@$(path) pip install biobox-cli==$(cli_version)
	@touch $@

.PHONY: test bootstrap ssh all
