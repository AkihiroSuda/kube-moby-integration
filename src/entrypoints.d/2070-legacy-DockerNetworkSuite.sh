#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerNetworkSuite"
exec ./hack/make.sh test-integration
