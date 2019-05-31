#!/bin/bash
set -eux
echo "running unit tests"
exec ./hack/test/unit
