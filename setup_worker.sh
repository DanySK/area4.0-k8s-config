#!/bin/sh
REPO="DanySK/area4.0-k8s-config"
GH_RAW="https://raw.githubusercontent.com"
REF="master"
sudo swupd update
sudo swupd bundle-add cloud-native-basic
sudo /usr/share/clr-k8s-examples/setup_system.sh
sudo systemctl stop docker
sudo systemctl stop containerd
sudo swupd bundle-add git
sudo curl -sL -o /etc/containers/policy.json $GH_RAW/$REPO/$REF/etc/containers/policy.json
