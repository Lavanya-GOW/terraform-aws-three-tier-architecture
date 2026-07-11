<div align="center">

# ☁️ AWS Three-Tier Architecture

### Production-Inspired Infrastructure on AWS using Terraform, Docker, Kubernetes (k3s) & GitHub Actions

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)

<p align="center">
<img src="https://capsule-render.vercel.app/api?type=waving&height=220&text=v2.0 Kubernetes Integration&fontAlign=50&fontAlignY=38&color=0:4F46E5,100:06B6D4&fontSize=45&animation=fadeIn"/>
</p>

Production-inspired AWS Infrastructure demonstrating Infrastructure as Code, CI/CD, Docker image automation, Kubernetes deployments and scalable cloud architecture.

</div>

---

# 📖 Overview

This project demonstrates how a production-inspired cloud infrastructure can be designed, deployed and managed entirely through Infrastructure as Code.

Rather than creating isolated AWS resources, the objective was to understand how networking, compute, security, automation, databases and deployment pipelines work together as a complete platform.

The infrastructure provisions an end-to-end AWS environment capable of automatically deploying containerized applications using Terraform, GitHub Actions, Kubernetes (k3s) and EC2 User Data.

---

# 🎯 Why I Built This

The primary objective of this project was to move beyond learning individual AWS services and instead understand how production systems are actually engineered.

This repository focuses on:

- Infrastructure as Code
- Production Networking
- Automation
- CI/CD
- Kubernetes Deployments
- Docker Image Management
- High Availability
- Cloud Debugging
- Infrastructure Troubleshooting

The goal wasn't simply making Terraform work.

The goal was understanding **why production infrastructure is designed the way it is.**

---

# ⭐ Highlights

- Built entirely using Terraform
- Production-inspired AWS Networking
- Infrastructure as Code
- Kubernetes (k3s) based Deployments
- Docker Image Pipeline
- GitHub Actions CI/CD
- Auto Scaling Groups
- External & Internal Load Balancers
- Bastion Host
- Amazon RDS PostgreSQL
- CloudWatch Monitoring
- Remote Terraform State
- Automated EC2 Bootstrapping using User Data
- Kubernetes ConfigMaps
- Kubernetes Deployments
- Redis StatefulSet
- Resource Requests & Limits
- Liveness & Readiness Probes
- Namespace Isolation
- Multi Availability Zone deployment

---

# 🏗 Architecture

```
                     Internet
                         │
                         ▼
           External Application Load Balancer
                         │
          ┌──────────────┴──────────────┐
          ▼                             ▼
     Frontend ASG                  Frontend ASG
          │
     k3s Cluster
          │
Frontend Deployment
          │
External Service
          │
────────────────────────────────────────────

           Internal Application Load Balancer

────────────────────────────────────────────
          │
     k3s Cluster
          │
Backend Deployment
          │
Redis StatefulSet
          │
Amazon RDS PostgreSQL
```

Every component is deployed inside a custom VPC distributed across multiple Availability Zones.

> **Current Version (v2.0):** Frontend and Backend are deployed in separate Kubernetes (k3s) clusters to preserve compatibility with the existing three-tier infrastructure. A future release will consolidate workloads into a single multi-node Kubernetes cluster before migrating to Amazon EKS.

---

# ☁ Infrastructure Components

| Service | Purpose |
|----------|----------|
| VPC | Network Isolation |
| Public Subnets | Load Balancers & Bastion |
| Frontend Subnets | Frontend Instances |
| Backend Subnets | Backend Instances |
| Database Subnets | PostgreSQL |
| Internet Gateway | Public Connectivity |
| NAT Gateway | Outbound Internet for Private Instances |
| Route Tables | Traffic Routing |
| Security Groups | Network Security |
| Bastion Host | Secure SSH Access |
| Launch Templates | Instance Configuration |
| Auto Scaling Groups | High Availability |
| External ALB | Internet Traffic |
| Internal ALB | Backend Communication |
| Target Groups | Health Monitoring |
| IAM Roles | Secure AWS Permissions |
| CloudWatch | Monitoring |
| RDS PostgreSQL | Persistent Database |
| k3s | Kubernetes Distribution |
| Kubernetes Deployments | Stateless Workloads |
| StatefulSets | Persistent Workloads |
| ConfigMaps | Runtime Configuration |
| Services | Internal & External Networking |

---

# 🚀 Features

- Infrastructure as Code
- Automated Infrastructure Provisioning
- Kubernetes-based Application Deployment
- Docker Image Automation
- Automated EC2 Bootstrapping
- Auto Scaling
- Internal Load Balancing
- External Load Balancing
- Bastion Host
- Private Networking
- PostgreSQL Database
- Kubernetes ConfigMaps
- Kubernetes Deployments
- Redis StatefulSet
- Namespace Isolation
- Resource Requests & Limits
- Health Checks (Readiness & Liveness)
- GitHub Actions Pipelines
- Remote Terraform Backend
- CloudWatch Monitoring
- Production-inspired Folder Structure
- Infrastructure Automation

---

# 🛠 Technology Stack

| Category | Technologies |
|------------|----------------|
| Cloud | AWS |
| IaC | Terraform |
| Programming | Python |
| Containers | Docker |
| Container Orchestration | Kubernetes (k3s) |
| CI/CD | GitHub Actions |
| Database | PostgreSQL & Redis |
| Networking | VPC, ALB, NAT Gateway |
| Monitoring | CloudWatch |
| Version Control | Git & GitHub |

---

# 📂 Repository Structure

```
aws-three-tier-architecture/

├── .github/
│   └── workflows/

├── docs/
│   ├── architecture.md
│   ├── deployment_notes.md
│   ├── design-decisions.md
│   ├── lessons_learned.md
│   └── roadmap.md

├── kubernetes/
│   ├── namespace.yaml
│   ├── configmaps.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   └── statefulset.yaml

├── images/
│   └── architecture.png

├── terraform_infra/
│   └── scripts/

├── Dockerfile

├── app.py

├── requirements.txt

├── README.md

└── LICENSE
```

---

# 🚧 Roadmap

## ✅ Version 1

- Terraform Infrastructure
- Docker Deployment
- GitHub Actions
- Auto Scaling
- Load Balancers
- RDS
- CloudWatch

## ✅ Version 2

- Kubernetes (k3s)
- Deployments
- StatefulSets
- ConfigMaps
- Namespace
- Resource Limits
- Health Probes
- Automated Kubernetes Bootstrap

## 🔄 Version 2.1

- Secrets
- Ingress
- Better Networking

## 🚀 Future Versions

- Single Multi-Node Kubernetes Cluster
- Prometheus
- Grafana
- Amazon EKS Migration
- GitOps (ArgoCD)
- Horizontal Pod Autoscaler
- Production Observability

---

## Architecture

<p align="center">

<img src="images/architecture.png" width="1000"/>

</p>

---

## 🤝 Acknowledgements

The initial three-tier AWS architecture was inspired by publicly available cloud architecture tutorials. This repository represents my own implementation, debugging process, infrastructure decisions, Kubernetes integration, and continuous evolution into a production-oriented platform.

---

## Thanks for visiting my project! ⭐