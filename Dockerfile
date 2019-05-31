# syntax = docker/dockerfile:1.1-experimental

# Run `docker build -t docker-dev:master https://github.com/docker/docker.git` to build the base image
ARG BASE=docker-dev:master
FROM ${BASE}
ARG DOCKER_GITCOMMIT=undefined
RUN --mount=target=/root/.cache,type=cache hack/make.sh build-integration-test-binary dynbinary
ENV DOCKER_INTEGRATION_TESTS_VERIFIED=1
ENV KEEPBUNDLE=1
ENV DOCKER_GITCOMMIT=${DOCKER_GITCOMMIT}

# emulate "indexed job" using kubectl and poor-mans-job-index.sh, until the "indexed job" gets implemented (kubernetes/kubernetes#14188)
RUN curl -L -o /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$(go env GOOS)/$(go env GOARCH)/kubectl && chmod +x /usr/local/bin/kubectl
COPY ./src/poor-mans-job-index.sh /usr/local/bin
COPY ./src/entrypoints.d /entrypoints.d
COPY ./src/entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
