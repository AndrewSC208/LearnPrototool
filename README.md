# Prototools
A tool created at Uber to define some standards as to how Google protocol buffers are used.

## Basic Commands of prototools
```sh
prototool help
prototool lint path/to/foo.proto path/to/bar.proto # file mode, specify multiple specific files
prototool lint idl/uber # directory mode, search for all .proto files recursively, obeying exclude_paths in prototool.yaml or prototool.json files
prototool lint # same as "prototool lint .", by default the current directory is used in directory mode
prototool create foo.proto # create the file foo.proto from a template that passes lint
prototool files idl/uber # list the files that will be used after applying exclude_paths from corresponding prototool.yaml or prototool.json files
prototool lint --list-linters # list all current lint rules being used
prototool lint --list-all-lint-groups # list all available lint groups, currently "google" and "uber"
prototool compile idl/uber # make sure all .proto files in idl/uber compile, but do not generate stubs
prototool generate idl/uber # generate stubs, see the generation directives in the config file example
prototool grpc idl/uber --address 0.0.0.0:8080 --method foo.ExcitedService/Exclamation --data '{"value":"hello"}' # call the foo.ExcitedService method Exclamation with the given data on 0.0.0.0:8080
```

## Using docker to compile all files
1. Install Docker
2. ```$ make protos```


