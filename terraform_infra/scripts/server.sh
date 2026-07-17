#!/bin/bash
#
# ==============================================================================
# Project : AWS Three-Tier Architecture v3
# Component : Kubernetes Control Plane Bootstrap
#
# Purpose:
#   - Install and configure the k3s control plane
#   - Wait until Kubernetes is operational
#   - Publish bootstrap information (Server IP & Join Token)
#   - Wait for worker nodes
#   - Deploy the application
#
# ==============================================================================

set -euo pipefail

exec > >(tee /var/log/server-bootstrap.log | logger -t server-bootstrap) 2>&1

echo "======================================================"
echo "Starting Kubernetes Control Plane Bootstrap"
echo "$(date)"
echo "======================================================"

###############################################
# Network Readiness
###############################################

echo "[1/8] Waiting for network connectivity..."

until ping -c1 security.ubuntu.com >/dev/null 2>&1
do
    echo "Network unavailable..."
    sleep 5
done

echo "Network Ready."

###############################################
# Install Dependencies
###############################################

echo "[2/8] Installing dependencies..."

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
    curl \
    git \
    jq \
    unzip

###############################################
# Disable Swap
###############################################

echo "[3/8] Disabling swap..."

swapoff -a || true

sed -i '/ swap / s/^/#/' /etc/fstab

###############################################
# Install k3s Server
###############################################

echo "[4/8] Installing k3s server..."

curl -sfL https://get.k3s.io | sh -

###############################################
# Configure kubectl
###############################################

echo "[5/8] Configuring kubectl..."

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml

mkdir -p /home/ubuntu/.kube

cp /etc/rancher/k3s/k3s.yaml \
   /home/ubuntu/.kube/config

chown ubuntu:ubuntu \
      /home/ubuntu/.kube/config

chmod 600 \
      /home/ubuntu/.kube/config

###############################################
# Wait for Kubernetes API
###############################################

echo "[6/8] Waiting for Kubernetes API..."

until kubectl get nodes >/dev/null 2>&1
do
    echo "Kubernetes API not ready..."
    sleep 5
done

echo "Control Plane Ready."

###############################################
# Read Bootstrap Information
###############################################

echo "[7/8] Reading bootstrap information..."

NODE_TOKEN=$(cat /var/lib/rancher/k3s/server/node-token)

SERVER_IP=$(hostname -I | awk '{print $1}')

echo "Server IP  : ${SERVER_IP}"
echo "Node Token : Retrieved"

###############################################
# TODO
# Publish Server IP & Node Token to AWS SSM
###############################################

# aws ssm put-parameter ...

###############################################
# Wait for Worker Nodes
###############################################

EXPECTED_NODES=3

echo "Waiting for ${EXPECTED_NODES} Ready nodes..."

until [ "$(kubectl get nodes --no-headers 2>/dev/null | grep -c ' Ready')" -eq "$EXPECTED_NODES" ]
do
    kubectl get nodes || true
    sleep 10
done

echo "Cluster Ready."

###############################################
# Deploy Application
###############################################

echo "[8/8] Deploying application..."

git clone https://github.com/Lavanya-GOW/terraform-aws-three-tier-architecture \
    /home/ubuntu/terraform-aws-three-tier-architecture || true

cd /home/ubuntu/terraform-aws-three-tier-architecture/scripts

chmod +x deploy.sh

./deploy.sh

echo "Bootstrap Complete."

kubectl get nodes

kubectl get pods -A

kubectl get svc -A

kubectl get ingress -A

echo "======================================================"
echo "Bootstrap Completed Successfully"
echo "$(date)"
echo "======================================================"