# jenkins-waker
OpenShift Pipelines Jenkins Waker

```
./waker.sh HOST TOKEN NAMESPACE 
```

This script watches for new builds in `NAMESPACE` and hits Jenkins service to wake it up so that it can pick up the new build.