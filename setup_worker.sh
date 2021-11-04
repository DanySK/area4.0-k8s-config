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
sudo mkdir -p /etc/containers/
sudo curl -sL -o /etc/containers/policy.json $GH_RAW/$REPO/$REF/etc/containers/policy.json

sudo mkdir -p /etc/sysctl.d/
sudo tee /etc/sysctl.d/99-kubernetes-cri.conf > /dev/null <<EOF
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
sudo sysctl --system

sudo systemctl mask $(sed -n -e 's#^/dev/\([0-9a-z]*\).*#dev-\1.swap#p' /proc/swaps) 2>/dev/null
sudo swapoff -a


