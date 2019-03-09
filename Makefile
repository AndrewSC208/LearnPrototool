ROOT_DIR=$(shell pwd)
TEMPLATE_DIR=$(ROOT_DIR)/template
PACKAGE_JSON_FILE=$(TEMPLATE_DIR)/package.json
GEN_DIR=$(ROOT_DIR)/gen
FILES=$(shell find $(GEN_DIR) -type f -name '*.js');
CONTAINER_NAME=builder
CONTAINER_TAG=1.0.0


## Make an npm module with docker
# for each generated js file
	# copy package.json template
	# update version
	# update FILE_NAME with name of js file 
	# npm install
	# npx webpack <name of js file>

.PHONY: all
all: protos

.PHONY: protos
protos:
	docker run $(CONTAINER_NAME):$(CONTAINER_TAG)

.PHONY: package
# TODO -> copy in node_modules and make each dir a module
package:
	for i in $(shell find $(GEN_DIR) -name *.js -exec dirname {} \;); \
		do \	
			cp $(PACKAGE_JSON_FILE) $$i; \
		done;

.PHONY: npm
npm:
	docker run \
	-it \
	--mount type=bind,source=$(GEN_SOURCE_DIR),target=/usr/src/app \
	node:11.10.1-alpine \
	sh

# .PHONY: jfrog
# jfrog:
# 	docker run \
# 	-it \
# 	--mount type=bind,source=$(GEN_SOURCE_DIR),target=/usr/src/app \
# 	docker.bintray.io/jfrog/jfrog-cli-go:latest \
# 	sh

.PHONY: env
env: 
	docker build -t $(CONTAINER_NAME):$(CONTAINER_TAG) .

.PHONY: runit
runit: env
	docker run \
	-it \
	$(CONTAINER_NAME):$(CONTAINER_TAG) \
	sh

.PHONY: clean
clean: 
	rm -rf gen

.PHONY: run-env
run-env:
	docker run builder:textv1

