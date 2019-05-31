#!/bin/bash
set -eu
: ${INDEX=-1}
: ${JOB_NAME=kube-moby-integration}
i=0
for pod in $(kubectl get pods -l job-name=${JOB_NAME} --sort-by=.metadata.creationTimestamp -o name); do
	if [ $INDEX -lt 0 -o $INDEX -eq $i ]; then
		echo "=== Pod $i: $pod ==="
		kubectl logs --all-containers $@ $pod
	fi
	i=$(($i + 1))
done
