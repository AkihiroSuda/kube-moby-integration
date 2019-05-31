# Moby Integration Test Runner for Kubernetes

Run `test-integration` of [Moby](https://github.com/moby/moby) (Docker daemon) in parallel using Kubernetes.

See [`./src/entrypoints.d`](./src/entrypoints.d) for the actual test scripts.


## Usage

Build and push the image:
```console
$ export DOCKER_BUILDKIT=1
$ IMAGE=example.com/kmi:t$(date +%s)
$ docker build -t docker-dev:master https://github.com/docker/docker.git
$ docker build -t $IMAGE .
$ docker push $IMAGE
```

Generate and apply the Kubernetes manifests:
```console
$ ./kube-moby-integration.yaml.sh $IMAGE
$ kubectl apply -f kube-moby-integration.generated.yaml
```

Watch output:
```console
$ kubectl get jobs -l jobgroup=kube-moby-integration
$ ./kubectl-logs-all.sh
```

## Implementation Note

As of June 2019, Kubernetes still does not implement "Indexed Job": https://github.com/kubernetes/kubernetes/issues/14188

The proper way to solve the issue would be to have a queue, but it seems kind of over-engineering: https://kubernetes.io/docs/tasks/job/fine-parallel-processing-work-queue/#starting-redis

So currently this project is implemented with "Job Group" pattern: https://kubernetes.io/docs/tasks/job/parallel-processing-expansion/

