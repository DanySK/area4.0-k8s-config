#! /bin/sh

# Assumes a `ServiceAccount` has been created by a user, and its name is $1
USER_NAME=$1

TOKEN_NAME=$(kubectl get secrets | grep danysk | awk '{print $1}')

kubectl get secrets $TOKEN_NAME -o jsonpath='{.data.token}'
