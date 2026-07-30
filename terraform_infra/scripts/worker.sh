#!/bin/bash
#
# ==============================================================================
# Project : AWS Three-Tier Architecture v3
# Component : Kubernetes Worker Bootstrap
#
# Purpose:
#   - Install and configure the k3s worker node
#   - Retrieve bootstrap information from AWS SSM
#   - Join the Kubernetes cluster
#   - Verify successful registration
#
# ==============================================================================

set -euo pipefail

exec > >(tee /var/log/worker-bootstrap.log | logger -t worker-bootstrap) 2>&1

echo "======================================================"
echo "Starting Kubernetes Worker Bootstrap"
echo "$(date)"
echo "======================================================"

###############################################
# Network Readiness
###############################################

echo "[1/6] Waiting for network..."

until ping -c1 security.ubuntu.com >/dev/null 2>&1
do
    echo "Network unavailable..."
    sleep 5
done

echo "Network Ready."

###############################################
# Install Dependencies
###############################################

echo "[2/6] Installing dependencies..."

export DEBIAN_FRONTEND=noninteractive

apt-get update

apt-get install -y \
    curl \
    jq \
    unzip \
    awscli

###############################################
# Disable Swap
###############################################

echo "[3/6] Disabling swap..."

swapoff -a || true

sed -i '/ swap / s/^/#/' /etc/fstab

###############################################
# Wait for Bootstrap Parameters
###############################################

echo "[4/6] Waiting for bootstrap parameters..."

until aws ssm get-parameter \
    --name "/k3s/server-ip" \
    >/dev/null 2>&1
do
    echo "Waiting for Control Plane..."
    sleep 10
done

SERVER_IP=$(aws ssm get-parameter \
    --name "/k3s/server-ip" \
    --query "Parameter.Value" \
    --output text)

NODE_TOKEN=$(aws ssm get-parameter \
    --name "/k3s/node-token" \
    --with-decryption \
    --query "Parameter.Value" \
    --output text)

echo "Bootstrap information received."

###############################################
# Install k3s Agent
###############################################

echo "[5/6] Joining Kubernetes cluster..."

curl -sfL https://get.k3s.io | \
K3S_URL="https://${SERVER_IP}:6443" \
K3S_TOKEN="${NODE_TOKEN}" \
sh -

###############################################
# Verify Cluster Join
###############################################

echo "[6/6] Waiting for kubelet..."

until systemctl is-active k3s-agent >/dev/null 2>&1
do
    echo "Waiting for k3s-agent..."
    sleep 5
done

systemctl status k3s-agent --no-pager

echo "======================================================"
echo "Worker successfully joined cluster."
echo "$(date)"
echo "======================================================"