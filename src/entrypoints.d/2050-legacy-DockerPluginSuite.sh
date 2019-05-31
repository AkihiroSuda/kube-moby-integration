#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerPluginSuite"
exec ./hack/make.sh test-integration
