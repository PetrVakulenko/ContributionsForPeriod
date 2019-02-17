# Public targets

.PHONY: .env
.env:
	cp .env.dist .env

.PHONY: repos.config
repos.config:
	cp repos.config.dist repos.config

.PHONY: build
build:
	./prepare_source.sh

.PHONY: clear
clear:
	rm -rf ./tmp
