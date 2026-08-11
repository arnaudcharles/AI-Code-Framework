SHELL := /bin/sh
IMAGE ?= local/example-app
TAG ?= dev

.PHONY: lint build scan smoke compose-up compose-down

lint:
	hadolint Dockerfile

build:
	docker build -t $(IMAGE):$(TAG) .

scan:
	trivy image --severity CRITICAL,HIGH --exit-code 1 $(IMAGE):$(TAG)

smoke:
	docker run --rm --name app-smoke $(IMAGE):$(TAG)

compose-up:
	docker compose up --build -d

compose-down:
	docker compose down
