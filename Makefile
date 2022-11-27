# init command params
GO := go
OS_NAME := linux
NATIVE_LIB := awesome.so

ifeq ($(OS),Windows_NT)
	OS_NAME = win32
	NATIVE_LIB = awesome.dll
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OS_NAME = linux
		NATIVE_LIB = libawesome.so
	endif
	ifeq ($(UNAME_S),Darwin)
		OS_NAME = darwin
		NATIVE_LIB = libawesome.dylib
	endif
endif

# env
export GO111MODULE := on

build-go: ## build go shared library
	cd go && $(GO) build -o $(NATIVE_LIB) -buildmode=c-shared awesome.go
	cp go/$(NATIVE_LIB) src/main/resources/$(OS_NAME)-x86-64

build: ## build jar
	make build-go
	mvn clean package assembly:single

deploy: ## deploy
	cd go && $(GO) build -o libawesome.so -buildmode=c-shared awesome.go
	cd go && CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 $(GO) build -o libawesome.dylib -buildmode=c-shared awesome.go
	cd go && CGO_ENABLED=1 GOOS=windows GOARCH=amd64 $(GO) build -o libawesome.dll -buildmode=c-shared awesome.go
	cp go/libawesome.so src/main/resources/linux-x86-64/
	cp go/libawesome.dylib src/main/resources/darwin-x86-64/
	cp go/awesome.dll src/main/resources/win32-x86-64/
	mvn deploy

test: ## test
	make build-go
	rm -f awesome.so
	mvn clean test -Djna.debug_load=true

clean: ## go clean && rm build output
	rm -f awesome.so
	mvn clean
	cd go && $(GO) clean

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build clean test help

## default target
.DEFAULT_GOAL := help
