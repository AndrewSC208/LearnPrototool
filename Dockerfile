FROM uber/prototool:latest as protoc

COPY . .

CMD prototool generate

