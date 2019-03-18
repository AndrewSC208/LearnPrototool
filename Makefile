ROOT_DIR=$(shell pwd)
TEMPLATE_DIR=$(ROOT_DIR)/template
PACKAGE_JSON_FILE=$(TEMPLATE_DIR)/package.json
GEN_DIR=$(ROOT_DIR)/gen
FILES=$(shell find $(GEN_DIR) -type f -name '*.js');
CONTAINER_NAME=builder
CONTAINER_TAG=1.0.0

.PHONY: all
all: protos

.PHONY: env
env: 
	docker build -t $(CONTAINER_NAME):$(CONTAINER_TAG) .

.PHONY: runit
runit: env
	docker run \
	-it \
	$(CONTAINER_NAME):$(CONTAINER_TAG) \
	sh

.PHONY: build
build: env
	docker run $(CONTAINER_NAME):$(CONTAINER_TAG)

.PHONY: protos
protos: env
	docker run \
	-it \
	--mount type=bind,source=${ROOT_DIR},target=/work \
	uber/prototool:latest \
	prototool generate

.PHONY: clean
clean: 
	rm -rf gen