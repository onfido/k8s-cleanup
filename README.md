## k8s-cleanup

Here are 3 cleanups you can apply on your kubernetes cluster:
* Cleans up exited containers and dangling images/volumes running as a DaemonSet (`deploy-ds.yml`).
* Cleans up old replica sets and finished jobs as a CronJob (`deploy-cron.yml`).
* Cleans up empty directory (not used anymore) in etcd as a CronJob (`etcd-empty-dir-cleanup.yml`).

You must have `batch/v2alpha1` enabled on your k8s API server runtime config in order to run the CronJob.

### Env vars
In the DaemonSet (`deploy-ds.yml`) you can set `DOCKER_CLEAN_INTERVAL` to modify the interval when it cleans up exited containers and dangling images/volumes; defaults to 30min (1800s).

In the CronJob (`deploy-cron.yml`) you can set `DAYS` to modify the maximum age of replica sets; defaults to 7 days.

### Deployment

```
kubectl --context CONTEXT -n kube-system apply -f rbac.yml
kubectl --context CONTEXT -n kube-system apply -f deploy-ds.yml
kubectl --context CONTEXT -n kube-system apply -f deploy-cron.yml
kubectl --context CONTEXT -n kube-system apply -f etcd-empty-dir-cleanup.yml 
```
