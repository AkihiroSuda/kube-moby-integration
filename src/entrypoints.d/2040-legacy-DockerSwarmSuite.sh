#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerSwarmSuite"
exec ./hack/make.sh test-integration
