#! /bin/sh

# To be executed by the user which firstly configured the K8s cluster.
# It is assumed that such user will have a local `kubelet` configuration in its local `.kube/config` file. 
# There, a cluster should be declared, along with its `certificate-authority-data` field.
# That field consists of a base64-encoded certificate, which is here extracted & decoded.

# Intended usage: `sh extract-ca.sh > ca.cert`.
# The generated `ca.cert` file should be provided to the cluster clients, and they should put it in their local `$HOME/.kube` directory.

kubectl config view --raw --flatten -o jsonpath="{.clusters[].cluster.certificate-authority-data}" | base64 --decode
