#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerExternalVolumeSuite"
exec ./hack/make.sh test-integration
