# Variables
DOCKER_IMAGE_NAME := your-image-name
DOCKER_TAG := latest
DEV_DOCKER_TAG := dev
DOCKER_REGISTRY := docker.io
DOCKERFILE_PATH := ./Dockerfile
DEV_DOCKERFILE_PATH := ./Dockerfile.dev

# Full image names
FULL_IMAGE_NAME := $(DOCKER_REGISTRY)/$(DOCKER_IMAGE_NAME):$(DOCKER_TAG)
DEV_IMAGE_NAME := $(DOCKER_REGISTRY)/$(DOCKER_IMAGE_NAME):$(DEV_DOCKER_TAG)

# Phony targets
.PHONY: all build push build-and-push build-dev push-dev build-and-push-dev clean help

# Default target
all: build-and-push

# Build the production Docker image
build:
	@echo "Building production Docker image: $(FULL_IMAGE_NAME)"
	docker build -t $(FULL_IMAGE_NAME) -f $(DOCKERFILE_PATH) .

# Push the production Docker image to the registry
push:
	@echo "Pushing production Docker image: $(FULL_IMAGE_NAME)"
	docker push $(FULL_IMAGE_NAME)

# Build and push the production Docker image
build-and-push: build push

# Build the development Docker image
build-dev:
	@echo "Building development Docker image: $(DEV_IMAGE_NAME)"
	docker build -t $(DEV_IMAGE_NAME) -f $(DEV_DOCKERFILE_PATH) .

# Push the development Docker image to the registry
push-dev:
	@echo "Pushing development Docker image: $(DEV_IMAGE_NAME)"
	docker push $(DEV_IMAGE_NAME)

# Build and push the development Docker image
build-and-push-dev: build-dev push-dev

clean:
	@echo "Cleaning up local Docker images..."
	docker rmi $(FULL_IMAGE_NAME)	
	docker rmi $(DEV_IMAGE_NAME)	

# Display help information
help:
	@echo "Usage:"
	@echo "  make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  build              Build the production Docker image"
	@echo "  push               Push the production Docker image to the registry"
	@echo "  build-and-push     Build and push the production Docker image"
	@echo "  build-dev          Build the development Docker image"
	@echo "  push-dev           Push the development Docker image to the registry"
	@echo "  build-and-push-dev Build and push the development Docker image"
	@echo "  help               Display this help message"
	@echo ""
	@echo "Variables:"
	@echo "  DOCKER_IMAGE_NAME  Name of the Docker image (default: $(DOCKER_IMAGE_NAME))"
	@echo "  DOCKER_TAG         Tag for the production Docker image (default: $(DOCKER_TAG))"
	@echo "  DEV_DOCKER_TAG     Tag for the development Docker image (default: $(DEV_DOCKER_TAG))"
	@echo "  DOCKER_REGISTRY    Docker registry URL (default: $(DOCKER_REGISTRY))"
	@echo "  DOCKERFILE_PATH    Path to the production Dockerfile (default: $(DOCKERFILE_PATH))"
	@echo "  DEV_DOCKERFILE_PATH Path to the development Dockerfile (default: $(DEV_DOCKERFILE_PATH))"

# Error handling for undefined targets
%:
	@echo "Error: Target '$@' not found."
	@echo "Run 'make help' to see available targets."
	@exit 1
