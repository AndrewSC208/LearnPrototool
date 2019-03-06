ROOT_DIR=$(shell pwd)
GEN_SOURCE_DIR = $(ROOT_DIR)/gen

.PHONY: all
all: protos package-js npm 

.PHONY: protos
protos:
	docker run \
	 --mount type=bind,source=$(ROOT_DIR),target=/work \
	 uber/prototool:latest \
	 prototool generate

.PHONY: package-js
package-js: protos
	echo $(shell find $(GEN_SOURCE_DIR) -name '*.js')
	echo "END OF LINE"

.PHONY: npm
## Make an npm module
# for each generated js file
	# copy package.json template
	# update version
	# update FILE_NAME with name of js file 
	# npm install
	# npx webpack <name of js file>
npm: protos
	docker run \
	-it \
	--mount type=bind,source=$(GEN_SOURCE_DIR),target=/usr/src/app \
	node:11.10.1-alpine \
	sh

.PHONY: jfrog
jfrog:
	docker run \
	-it \
	--mount type=bind,source=$(GEN_SOURCE_DIR),target=/usr/src/app \
	docker.bintray.io/jfrog/jfrog-cli-go:latest \
	sh

.PHONY: clean
clean: 
	rm -rf gen
