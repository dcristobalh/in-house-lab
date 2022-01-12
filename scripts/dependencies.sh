#!/usr/bin/env bash

VERSION_K3D=v5.0.0
VERSION_KUBECTL=1.22.0
VERSION_HELM=v3.5.3
CLUSTER_NAME=in-house-lab

function checkclusterexists() {
  clusterexists=$(k3d cluster list $CLUSTER_NAME| wc -l)

  if [[ $clusterexists -gt 1 ]]; then
    echo "there is already a $CLUSTER_NAME cluster. Wiping it."
    k3d cluster delete $CLUSTER_NAME
  fi
}

function dependencies() {
    if [ ! -x "$(command -v "kubectl")" ]; then
        wget https://dl.k8s.io/release/v${VERSION_KUBECTL}/bin/linux/amd64/kubectl -O /tmp/kubectl
        sudo chmod +x /tmp/kubectl
        sudo mv /tmp/kubectl /usr/local/bin
    else 
        echo "kubectl already installed. No installation required"
    fi

    if [ ! -x "$(command -v "k3d")" ]; then
        wget https://github.com/rancher/k3d/releases/download/${VERSION_K3D}/k3d-linux-amd64 -O /tmp/k3d
        sudo chmod +x /tmp/k3d
        sudo mv /tmp/k3d /usr/local/bin
    else
        echo "k3d already installed. No installation required"
    fi

    if [ ! -x "$(command -v "helm")" ]; then
        wget https://get.helm.sh/helm-v${VERSION_HELM}-linux-amd64.tar.gz -O /tmp/helm.tar.gz
        tar -xvf /tmp/helm.tar.gz -C /tmp
        sudo chmod +x /tmp/linux-amd64/helm
        sudo mv /tmp/linux-amd64/helm /usr/local/bin
    else   # helm already installed
        echo "helm already installed. No installation required"
    fi
}

checkclusterexists
dependencies
