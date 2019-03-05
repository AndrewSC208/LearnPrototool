ROOT_DIR=$(shell pwd)
protos:
	docker run \
	 -it \
	 --mount type=bind,source=${ROOT_DIR},target=/work \
	 uber/prototool:latest \
	 prototool generate
