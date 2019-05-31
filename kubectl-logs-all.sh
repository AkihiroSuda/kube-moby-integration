#!/bin/bash
set -eu
: ${JOBGROUP_NAME=kube-moby-integration}
for job in $(kubectl get jobs -l jobgroup=$JOBGROUP_NAME -o name | sort -V); do
	command=$(kubectl get $job -o jsonpath='{.spec.template.spec.containers[*].command}')
	podst=$(kubectl describe $job | grep "Pods Statuses")
	echo "===== $job $command ($podst) ====="
	kubectl logs --all-containers $job
done
