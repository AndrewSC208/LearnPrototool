FROM uber/prototool:latest as protoc
# add tools, and .protoc files to build environment
COPY . .
# generate protoc output
RUN ["prototool", "generate"]
# new node image
FROM node:11.10.1-alpine
# copy output from last stage to current stage
COPY --from=protoc ./ ./
# build npm modules
WORKDIR /work/template
# install npm modules
RUN npm install
# chagne back to root
WORKDIR /work
# chmod the scirpt so it can be run in the docker container
RUN chmod +x ./cmd/npm.sh
# run the script
RUN ./cmd/npm.sh
