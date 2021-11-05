
#! /bin/sh

# To be executed by the user which firstly configured the K8s cluster.
# It is assumed that such user will have a local `kubelet` configuration in its local `.kube/config` file. 
# There, a cluster should be declared, along with its `server` field.
# That field consists of an URL, upon which the cluster's master node is listening for requests.
# That URL is the entry point to be contacted by a `kubelet` client to interact with the cluster.

# Intended usage: `SERVER_URL=$(sh extract-server.sh)`.
# The value of `SERVER_URL` should then be provided to the cluster clients, and they should use it to create their own `kubelet` configuration

kubectl config view --raw --flatten -o jsonpath="{.clusters[].cluster.server}"
