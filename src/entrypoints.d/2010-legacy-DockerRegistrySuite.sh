#!/bin/bash
set -eux
export TESTFLAGS="-check.f DockerRegistrySuite"
exec ./hack/make.sh test-integration
