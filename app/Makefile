.PHONY: default check test build image

SRC_DIR := src
OUTPUT := whoami

ifeq ($(IMAGE_NAME),)
$(error IMAGE_NAME is not set. Use 'make image IMAGE_NAME=<your-image-name>')
endif

default: check test build

check:
	golangci-lint run $(SRC_DIR)/...

test:
	go test -v -cover $(SRC_DIR)/...

build:
	CGO_ENABLED=0 go build -a --trimpath --installsuffix cgo --ldflags="-s" -o $(OUTPUT) $(SRC_DIR)/*.go

image:
	docker build -t $(IMAGE_NAME) .
