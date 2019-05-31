#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerHubPullSuite"
exec ./hack/make.sh test-integration
