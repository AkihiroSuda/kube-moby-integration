#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerRegistryAuthHtpasswdSuite -check.f DockerRegistryAuthTokenSuite"
exec ./hack/make.sh test-integration
