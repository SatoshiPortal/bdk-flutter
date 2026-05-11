.DEFAULT_GOAL := help
PROJECTNAME=$(shell basename "$(PWD)")

.PHONY: help
help: makefile
	@echo
	@echo " Available actions in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

## init: Install missing dependencies.
init:
	cargo install flutter_rust_bridge_codegen --version 2.9.0
## :

all: init generate-bindings

generate-bindings:
	@echo "[GENERATING FRB CODE] $@"
	flutter_rust_bridge_codegen generate && dart run build_runner build
	@echo "[Done ✅]"

## reproduce-darwin: Rebuild macOS/iOS binaries and compare them to signed release assets.
reproduce-darwin:
	./reproducible_builds/reproduce-darwin.sh

## reproduce-linux: Rebuild Linux binaries in Docker and compare them to signed release assets.
reproduce-linux:
	./reproducible_builds/reproduce-linux-docker.sh

## reproduce-android: Rebuild Android binaries in Docker and compare them to signed release assets.
reproduce-android:
	./reproducible_builds/reproduce-android-docker.sh






