#!/bin/bash

# -----------------------------------------------------------------------------
# Bootstrap Script
# Project : AWS Three-Tier Architecture v2
# Purpose : Provision k3s, deploy Kubernetes manifests, and bootstrap the app.
# -----------------------------------------------------------------------------

set -euo pipefail
exec > /var/log/user-data.log 2>&1

date

ip addr
ip route
nslookup security.ubuntu.com || true
curl -I http://security.ubuntu.com || true

echo "Waiting 60 seconds for networking..."
sleep 60

curl -I http://security.ubuntu.com || true

until sudo apt update; do
    echo "apt update failed. Retrying in 10 seconds..."
    sleep 10
done

sudo apt upgrade -y
sudo apt install -y git curl

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

until kubectl get nodes >/dev/null 2>&1; do
    echo "Waiting for Kubernetes API..."
    sleep 10
done

sudo mkdir -p /home/ubuntu/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/ubuntu/.kube/config
sudo chown ubuntu:ubuntu /home/ubuntu/.kube/config
sudo chmod 600 /home/ubuntu/.kube/config

cd /home/ubuntu

if [ ! -d "terraform-aws-three-tier-architecture" ]; then
    git clone https://github.com/Lavanya-GOW/terraform-aws-three-tier-architecture
fi

cd terraform-aws-three-tier-architecture/kubernetes-files

kubectl apply -f namespace.yaml

kubectl apply -f configmaps.yaml

kubectl apply -f statefulset.yaml

kubectl rollout status statefulset/redis -n three-tier-app

kubectl apply -f deployment.yaml

kubectl apply -f backend-service.yaml

kubectl rollout status deployment/web -n three-tier-app

kubectl logs -l app=flask -n three-tier-app --tail=20 || true

kubectl get nodes
kubectl get deployments -n three-tier-app
kubectl get statefulsets -n three-tier-app
kubectl get pods -o wide -n three-tier-app
kubectl get svc -n three-tier-app
kubectl get pvc -n three-tier-app

date