#!/bin/bash
set -eu

echo "+ JOB_NAME=$JOB_NAME, POD_NAME=$POD_NAME"
while :; do
	# JOB_NAME and POD_NAME needs to be set
	index=$(poor-mans-job-index.sh)
	if [[ $? == 0 ]]; then
		break
	fi
	sleep 10
done
echo "* Index=$index"

: ${ENTRYPOINTS=/entrypoints.d}
chosen=$(ls $ENTRYPOINTS | sed -n $(($index + 1))p)
if [[ -z $chosen ]]; then
	echo >&2 "Bad index: $index (needs to be 0-$(($(ls $ENTRYPOINTS | wc -l) - 1)))"
	exit 1
fi
echo "* Executing $ENTRYPOINTS/$chosen"
exec $ENTRYPOINTS/$chosen $@
