EW_VERSION = 7.9
BUILD = 3
VERSION = $(EW_VERSION)-build$(BUILD)

PACKAGE = earthworm
DOCKER_REGISTRY = cmalek/earthworm

#======================================================================

version:
	@echo ${VERSION}

image_name:
	@echo ${DOCKER_REGISTRY}/${PACKAGE}:${VERSION}

force-build:
	docker build --no-cache -t earthworm:${VERSION} .
	docker tag ${PACKAGE}:${VERSION} earthworm:latest
	docker tag ${PACKAGE}:${VERSION} earthworm:${EW_VERSION}
	docker image prune -f

build:
	docker build -t ${PACKAGE}:${VERSION} .
	docker tag ${PACKAGE}:${VERSION} ${PACKAGE}:latest
	docker tag ${PACKAGE}:${VERSION} ${PACKAGE}:${EW_VERSION}
	docker image prune -f

tag:
	docker tag ${PACKAGE}:${VERSION} ${DOCKER_REGISTRY}/${PACKAGE}:${VERSION}
	docker tag ${PACKAGE}:latest ${DOCKER_REGISTRY}/${PACKAGE}:latest
	docker tag ${PACKAGE}:${EW_VERSION} ${DOCKER_REGISTRY}/${PACKAGE}:${EW_VERSION}

push: tag
	docker push ${DOCKER_REGISTRY}/${PACKAGE}:${EW_VERSION}

dev:
	docker-compose up

dev-detached:
	docker-compose up -d

docker-clean:
	docker stop $(shell docker ps -a -q)
	docker rm $(shell docker ps -a -q)


pipeline-create:
	aws codebuild create-project --cli-input-json file://codepipeline/codebuild-docker-build.json
	aws codepipeline create-pipeline --cli-input-json file://codepipeline/codepipeline.json

pipeline-update-projects:
	aws codebuild update-project --cli-input-json file://codepipeline/codebuild-docker.json

pipeline-update: pipeline-update-projects
	aws codepipeline update-pipeline --cli-input-json file://codepipeline/codepipeline.json
