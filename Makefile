REPO = mimzee
IMAGE = nginx-php
VERSION = 0.5.0
EXTRAVERSION =

IMAGE_NAME = $(REPO)/$(IMAGE)
IMAGE_VERSION = v$(VERSION)$(EXTRAVERSION)
IMAGE_FQN = $(IMAGE_NAME):$(IMAGE_VERSION)

.PHONY: build

default:	build

build:
	@docker build \
		--build-arg VCS_REF=`git rev-parse --short HEAD` \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VERSION=$(IMAGE_VERSION) \
		-t $(IMAGE_NAME):local-build .

travis-build:
	@docker build \
		--build-arg VCS_REF=$(TRAVIS_COMMIT) \
		--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
		--build-arg VERSION=$(IMAGE_VERSION) \
		-t $(IMAGE_NAME):travis-build .
