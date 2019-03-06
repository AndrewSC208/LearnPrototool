ROOT_DIR=$(shell pwd)

.PHONY: all
all: protos npm 

.PHONY: protos
protos:
	docker run \
	 --mount type=bind,source=${ROOT_DIR},target=/work \
	 uber/prototool:latest \
	 prototool generate

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
	--mount type=bind,source=${ROOT_DIR}/gen,target=/usr/src/app \
	node:11.10.1-alpine \
	sh
	

.PHONY: clean
clean: 
	rm -rf gen
