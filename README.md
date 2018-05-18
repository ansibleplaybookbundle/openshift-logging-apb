openshift-logging-apb
=====================

Introduction
------------
This APB will install openshift-logging. The best experience is achieved by running `oc cluster up --enable=openshift-logging` as it will handle creation of prerequisite resources. It should be possible to run this APB after cluster creation via the UI, but it is not well tested. If you would like to do so see the requirements section below for details on what is required.

Requirements
------------
- The openshift-logging namespace must exist in advance of running the APB. Use `kubectl create namespace openshift-logging`. Do not attempt to use oc. It will refuse to create `openshift-*` namespaces.
- Once the openshift-logging namespace exists you need to create a secret with the admin.kubeconfig for your cluster. This can be done similar to `oc create secret generic openshift-logging-apb --namespace=openshift-logging --from-file=openshift.local.clusterup/kube-apiserver/admin.kubeconfig`. By default openshift.local.clusterup exists in the directory oc cluster up was run. It's placement can be affected by the --base-dir option. For instance if you run `oc cluster up --base-dir=/tmp/openshift.local.clusterup` the admin.kubeconfig will be loaded at `/tmp/openshift.local.clusterup/kube-apiserver/admin.kubeconfig`. In an openshift-enterprise install the admin.kubeconfig exists at /etc/origin/master/admin.kubeconfig.
- Ensure when running the APB that you enter the public hostname for your cluster in this public_hostname parameter field. This will be used to create routes, so if it is incorrect your routes will likely not resolve properly.
