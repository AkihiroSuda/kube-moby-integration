#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerDaemonSuite"
exec ./hack/make.sh test-integration
