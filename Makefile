#
# Makefile
# edgardleal, 2020-03-12 09:50
#

DONE = echo ✓ $@ done
SOURCES = $(shell find src/ -type f -name '*.ts')
JSON_GET_VALUE = grep $1 | head -n 1 | sed 's/[," ]//g' | cut -d : -f 2
APP_NAME = $(shell cat package.json 2>/dev/null | $(call JSON_GET_VALUE,name))
modules = $(wildcard node_modules/*/*.js)
.PHONY: all clean help run build install lint

all: run

node_modules/.last_lint: $(SOURCES)
	yarn lint
	@touch $@

lint: ## lint: run eslint
lint: node_modules/.last_lint
	@$(DONE)

node_modules/.bin/tsc: package.json
	yarn || npm i
	@touch $@

run: ## run: build and run this project
run: dist/index.js
	DEBUG=project* node dist/index.js

index.ts: $(SOURCES)

dist/index.js: index.ts node_modules/.last_lint node_modules/.bin/tsc coverage/index.html
	./node_modules/.bin/tsc -p tsconfig.json

build: ## build: transpile typescript to javascript
build: dist/index.js
	@$(DONE)

node_modules/.bin/jest: package.json
	yarn || npm i
	@touch $@

install: ## install: install project dependencies
install: node_modules/.bin/jest
	@$(DONE)

coverage/index.html: $(SOURCES) node_modules/.bin/jest
	DEBUG=project* yarn test --coverage --coverageReporters html

test: ## test: run unit tests
test: coverage/index.html
	@$(DONE)

clean: ## clean: Remove ./node_modules and call clean in all children projects
	git clean -fdX
	@$(DONE)

hel%: ## help: Show this help message.
	@echo "usage: make [target] ..."
	@echo ""
	@echo "targets:"
	@grep -Eh '^.+:\ ##\ .+' ${MAKEFILE_LIST} | cut -d ' ' -f '3-' | column -t -s ':'


# vim:ft=make
