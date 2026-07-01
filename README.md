# AWS Three-Tier Flask Application using Terraform, Docker & GitHub Actions

## Overview

This project demonstrates the deployment of a production-inspired three-tier application on AWS using Infrastructure as Code (Terraform), containerization (Docker), and CI/CD (GitHub Actions).

The infrastructure is completely provisioned using Terraform and supports automatic scaling, load balancing, and secure networking.

---

## Tech Stack

- AWS
- Terraform
- Docker
- Docker Compose
- GitHub Actions
- Flask
- Redis
- PostgreSQL (RDS)
- Auto Scaling Groups
- Application Load Balancers
- CloudWatch
- IAM

---

## Architecture

```
Internet
    │
    ▼
Internet Gateway
    │
    ▼
External Application Load Balancer
    │
    ▼
Frontend Auto Scaling Group
    │
    ▼
Internal Application Load Balancer
    │
    ▼
Backend Auto Scaling Group
    │
    ▼
Amazon RDS PostgreSQL
```

Infrastructure also includes:

- Bastion Host
- NAT Gateway
- Public and Private Subnets
- Route Tables
- IAM Roles
- CloudWatch Alarms
- Security Groups
- Remote Terraform State

---

## Features

- Infrastructure as Code
- Highly Available Architecture
- Multi-AZ Deployment
- Automatic Scaling
- Internal & External Load Balancing
- CI/CD Pipelines
- Dockerized Application
- Bastion Host Access
- Secure Private Networking
- Remote Terraform Backend

---

## Repository Structure

```
.
├── terraform_infra/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── backend.tf
│   ├── scripts/
│   └── ...
│
├── .github/
│   └── workflows/
│       ├── docker_pipeline.yml
│       ├── terraform_pipeline.yml
│       ├── terraform_apply.yml
│       └── terraform_destroy.yml
│
├── Dockerfile
├── docker-compose.yml
├── app.py
├── requirements.txt
└── README.md
```

---

## GitHub Actions

This repository contains four workflows.

### Docker Pipeline

- Build Docker image
- Push to DockerHub
- Smoke Test

### Terraform Pipeline

- fmt
- validate
- plan

### Terraform Apply

Manual Deployment

### Terraform Destroy

Manual Infrastructure Cleanup

---

## Deployment

```bash
terraform init
terraform plan
terraform apply
```

or

Run the GitHub Actions workflow:

Terraform Apply

---

## Future Improvements

- Kubernetes Migration
- Helm Charts
- ArgoCD
- Monitoring using Prometheus
- Grafana
- EKS Deployment
- Service Mesh

---

## Author

Built by Lavanya as part of a Cloud/DevOps learning journey.
