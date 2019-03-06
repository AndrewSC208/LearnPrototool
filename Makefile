ROOT_DIR=$(shell pwd)

.PHONY: all
all: protos npm 

.PHONY: protos
protos:
	docker run \
	 -it \
	 --mount type=bind,source=${ROOT_DIR},target=/work \
	 uber/prototool:latest \
	 prototool generate

.PHONY: npm
npm: protos
	# for each .js file copy package.json template and sed out the placeholder name with the filename of the js file. 
