#!/bin/bash
#local Kubernetes cluster in Docker containers for home/development/testing env.
# Author: localsnet
#Thanks to Laurent Roffe for his article https://medium.com/@laurent.roffe_24715/first-nextcloud-deployment-in-k8s-manual-full-steps-eca2566751e7
arch="$(uname -m)"
version="0.19.0"
cluster_name="nc"
#Are you root?
if [ "$USER" != root ]; then
  printf "Script must run with root privileges \n"
  exit 255
fi

#Adapt some sysctl setting on the host machine
sysctl net.ipv4.ip_unprivileged_port_start=80
sysctl fs.inotify.max_user_instances=4096

#Create a cluster with three nodes
# For AMD64 / x86_64
if [[ $arch = x86_64 ]]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v$version/kind-linux-amd64
# For ARM64
elif [[ $arch = aarch64 ]]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v$version/kind-linux-arm64
else
  printf "Your architecture $arch not supported"
  exit 256
fi

chmod +x ./kind
mv ./kind /usr/local/bin/kind
kind create cluster --name $cluster_name --config cluster_3_nodes.yaml