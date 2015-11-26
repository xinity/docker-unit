# Set an output prefix, which is the local directory if not specified
GIT_BRANCH=$(shell git rev-parse --abbrev-ref HEAD)

.PHONY: all clean image binaries

all: clean binaries

clean:
		@echo "+ $@"
		@rm -rf bundles

image:
		@echo "+ $@"
		@docker build -t docker-unit-build:${GIT_BRANCH} .

binaries: image
		@echo "+ $@"
		$(eval C_ID := $(shell docker create docker-unit-build:${GIT_BRANCH}))
		@docker start -a ${C_ID}
		@docker cp ${C_ID}:/bundles .
		@docker rm ${C_ID}

test: image
		@echo "+ $@"
		$(eval C_ID := $(shell docker run -it --entrypoint /usr/local/bin/make_tests.sh docker-unit-build:${GIT_BRANCH}))
		@docker rm ${C_ID}
