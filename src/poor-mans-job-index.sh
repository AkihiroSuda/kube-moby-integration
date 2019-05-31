#!/bin/bash
# prints 0-based index for $POD_NAME which should belong to the job named $JOB_NAME.
# This is *RACY* - multiple pods may see the identical index.
# But should be enough for integration tests.
set -eu

index1=$(kubectl get pods -l job-name=$JOB_NAME --field-selector "status.phase!=Failed" --sort-by=.metadata.creationTimestamp -o=name | sed -e 's@^pod/@@g' | grep -n -m1 -w $POD_NAME | sed -e s/:.*//g)
if [[ -z $index1 ]]; then
	echo >&2 "could not get index"
	exit 1
fi
index0=$(($index1 - 1))
echo $index0
