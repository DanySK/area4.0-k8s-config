#! /bin/sh

# should be provided by an admin (which can extract it via `sh extract-server.sh`)
SERVER_URL=$1

# should be provided by an admin (which can extract it via `sh extract-ca.sh`)
CA_FILE_PATH=$2

# totally custom username (no need to make it equal to the username used within the cluster)
USER_NAME=$3

# should be provided by an admin (which can be extracted via `sh extract-token.sh`)
USER_TOKEN=$4

CLUSTER_NAME=${5:-kubernetes}

kubectl config set-cluster $CLUSTER_NAME --server=$SERVER_URL --certificate-authority=$CA_FILE_PATH
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
