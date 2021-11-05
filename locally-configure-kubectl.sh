#! /bin/sh

SERVER_URL=$1
CA_FILE=$2
USER_NAME=$3
USER_TOKEN=$4

CLUSTER_NAME=${5:-kubernetes}

kubectl config set-cluster $CLUSTER_NAME --server=$SERVER_URL --certificate-authority=$USER_TOKEN
kubectl config set-credentials $USER_NAME --token=$USER_TOKEN
CONTEXT_NAME="$USER_NAME@$CLUSTER_NAME"
kubectl config set-context $CONTEXT_NAME --cluster $CLUSTER_NAME --user $USER_NAME
kubectl config use-context $CONTEXT_NAME

# How to verify this worked: the command
#     kubectl cluster-config
# should print something like:
# 
#     Kubernetes master is running at $SERVER_URL
#     KubeDNS is running at $SERVER_URL/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
