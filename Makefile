#!/usr/bin/env bash

dev:clean fmt bindata build run

all: dev con

fmt:
	gofmt -l -w ./

build:
	go build -v -o go-mygen/output/go-mygen ./go-mygen/

run:
	go-mygen/output/go-mygen

vendor:
	govendor add +e
	govendor remove +u

bindata:
	go-bindata -pkg gomygen -o ./bindata.go tpl/
clean:
	rm -rf go-mygen/output/go-mygen
	rm -rf go-mygen/output/markdown.md
	rm -rf go-mygen/output/db_entity/
	rm -rf go-mygen/output/db_models/

con:
	go-mygen/output/go-mygen -h localhost -P 3308 -u root -d kindled

bench:
	go test -test.bench=".*"  -benchmem
