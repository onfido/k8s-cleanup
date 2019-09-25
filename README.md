## k8s-cleanup

Here are 3 cleanups you can apply on your kubernetes cluster:
* Cleans up exited containers and dangling images/volumes running as a DaemonSet (`docker-clean.yml`).
* Cleans up old replica sets, finished jobs and unrecycled evicted pods as a CronJob (`k8s-clean.yml`).
* Cleans up empty directory (not used anymore) in etcd as a CronJob (`etcd-empty-dir-cleanup.yml`).

You must have `batch/v1beta1` enabled on your k8s API server runtime config in order to run the CronJob.

### Env vars
In the DaemonSet (`docker-clean.yml`) you can set `DOCKER_CLEAN_INTERVAL` to modify the interval when it cleans up exited containers and dangling images/volumes; defaults to 30min (1800s).

In the CronJob (`k8s-clean.yml`) you can set `DAYS` to modify the maximum age of replica sets; defaults to 7 days.

### Deployment

```
kubectl --context CONTEXT -n kube-system apply -f rbac.yml
kubectl --context CONTEXT -n kube-system apply -f docker-clean.yml
kubectl --context CONTEXT -n kube-system apply -f k8s-clean.yml
kubectl --context CONTEXT -n kube-system apply -f etcd-empty-dir-cleanup.yml
```
