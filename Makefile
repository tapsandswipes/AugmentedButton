#!/bin/bash -e -o pipefail

GITHUB_USER = tapsandswipes
TARGET_NAME = $(shell swift package dump-package | jq '.products[0].name' | tr -d '"')
TARGET_NAME_LOWERCASE = $(shell echo ${TARGET_NAME} | tr '[:upper:]' '[:lower:]')
REPO_NAME = $(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P | sed 's:.*/::')

.PHONY: clean help project requirebrew

checkuser:
	ifndef GITHUB_USER
	$(error Please set your GITHUB_USER in the script in line 3)
	endif

help: requirebrew 
	@echo Usage:
	@echo ""
	@echo "  make clean       - removes all generated products"
	@echo "  make docc        - Generate static docs to be hosted in GitHub"
	@echo ""

clean:
	rm -rf .build
	rm -rf .swiftpm
	rm -rf build
	rm -rf docs

docc: requirejq
	rm -rf docs
	mkdir -p docs
	xcodebuild build -scheme ${TARGET_NAME} -destination generic/platform=iOS
	DOCC_JSON_PRETTYPRINT=YES
	xcodebuild docbuild \
		-scheme ${TARGET_NAME} \
		-destination generic/platform=iOS \
		OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path ${REPO_NAME} --output-path docs --emit-digest"
	cat docs/linkable-entities.json | jq '.[].referenceURL' -r | sort > docs/all_identifiers.txt
	sort docs/all_identifiers.txt | sed -e "s/doc:\/\/${TARGET_NAME}\/documentation\\///g" | sed -e "s/^/- \`\`/g" | sed -e 's/$$/``/g' > docs/all_symbols.txt
	@echo "1. Enable project pages in https://github.com/${GITHUB_USER}/${REPO_NAME}/settings/pages"
	@echo "2. Push the docs folder to GitHub"
	@echo "3. Check https://${GITHUB_USER}.github.io/${REPO_NAME}/documentation/${TARGET_NAME_LOWERCASE}/"

requirebrew:
	@if ! command -v brew &> /dev/null; then echo "Please install brew from https://brew.sh/"; exit 1; fi

requirejq: requirebrew
	@if ! command -v jq &> /dev/null; then echo "Please install jq using 'brew install jq'"; exit 1; fi

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
