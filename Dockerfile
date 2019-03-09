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