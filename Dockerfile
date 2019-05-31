# syntax = docker/dockerfile:1.1-experimental

# Run `docker build -t docker-dev:master https://github.com/docker/docker.git` to build the base image
ARG BASE=docker-dev:master
FROM ${BASE}
ARG DOCKER_GITCOMMIT=undefined
RUN --mount=target=/root/.cache,type=cache hack/make.sh build-integration-test-binary dynbinary
ENV DOCKER_INTEGRATION_TESTS_VERIFIED=1
ENV KEEPBUNDLE=1
ENV DOCKER_GITCOMMIT=${DOCKER_GITCOMMIT}

COPY ./src/entrypoints.d /entrypoints.d
