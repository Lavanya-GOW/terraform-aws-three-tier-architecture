#!/bin/bash
#
# ==============================================================================
# Project : AWS Three-Tier Architecture v3
# Component : Kubernetes Application Deployment
#
# Purpose:
#   - Deploy all Kubernetes resources
#   - Validate each deployment
#   - Ensure application health
#
# ==============================================================================

set -euo pipefail

exec > >(tee /var/log/deploy.log | logger -t deploy) 2>&1

echo "======================================================"
echo "Starting Application Deployment"
echo "$(date)"
echo "======================================================"

###############################################
# Repository
###############################################

PROJECT_DIR="/home/ubuntu/terraform-aws-three-tier-architecture"

if [ ! -d "${PROJECT_DIR}" ]; then

    echo "Cloning repository..."

    git clone \
        https://github.com/Lavanya-GOW/terraform-aws-three-tier-architecture \
        "${PROJECT_DIR}"

fi

cd "${PROJECT_DIR}/kubernetes-files"

###############################################
# Namespace
###############################################

echo "Deploying Namespace..."

kubectl apply -f base/namespace.yaml

###############################################
# ConfigMaps
###############################################

echo "Deploying ConfigMaps..."

kubectl apply -f base/configmaps.yaml

###############################################
# Secrets
###############################################

if [ -f base/secrets.yaml ]; then

    echo "Deploying Secrets..."

    kubectl apply -f base/secrets.yaml

fi

###############################################
# Redis
###############################################

echo "Deploying Redis..."

kubectl apply -f redis/

echo "Waiting for Redis..."

kubectl rollout status \
statefulset/redis \
-n three-tier-app \
--timeout=300s

###############################################
# Backend
###############################################

echo "Deploying Backend..."

kubectl apply -f backend/

echo "Waiting for Backend..."

kubectl rollout status \
deployment/backend \
-n three-tier-app \
--timeout=300s

###############################################
# Frontend
###############################################

echo "Deploying Frontend..."

kubectl apply -f frontend/

echo "Waiting for Frontend..."

kubectl rollout status \
deployment/frontend \
-n three-tier-app \
--timeout=300s

###############################################
# Ingress
###############################################

echo "Deploying Ingress..."

kubectl apply -f ingress.yaml

###############################################
# Validation
###############################################

echo "Deployment Summary"

kubectl get nodes

echo

kubectl get pods -n three-tier-app

echo

kubectl get svc -n three-tier-app

echo

kubectl get ingress -n three-tier-app

echo

kubectl get pvc -n three-tier-app

echo

kubectl get deployments -n three-tier-app

echo

kubectl get statefulsets -n three-tier-app

echo "======================================================"
echo "Application Successfully Deployed"
echo "$(date)"
echo "======================================================"