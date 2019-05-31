#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerSuite"
exec ./hack/make.sh test-integration
