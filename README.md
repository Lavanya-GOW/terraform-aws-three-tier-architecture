# ☁️ AWS Three-Tier Architecture

### Production-Inspired Infrastructure on AWS using Terraform, Docker, Kubernetes (k3s), GitHub Actions, Prometheus & Grafana.

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)
![Prometheus](https://shields.io)
![Grafana](https://shields.io)

Production-inspired AWS Infrastructure demonstrating Infrastructure as Code, CI/CD, Docker image automation, Kubernetes deployments and scalable cloud architecture.

---

# 📖 Overview

This project demonstrates how a production-inspired cloud infrastructure can be designed, deployed and managed entirely through Infrastructure as Code.

Rather than creating isolated AWS resources, the objective was to understand how networking, compute, security, automation, databases and deployment pipelines work together as a complete platform.

The infrastructure provisions an end-to-end AWS environment capable of automatically deploying containerized applications using Terraform, GitHub Actions, Kubernetes (k3s) and EC2 User Data.

The architecture has progressively evolved from basic AWS infrastructure into a multi-node Kubernetes platform with application monitoring using Prometheus and Grafana.

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
- Application Monitoring
- Infrastructure Monitoring
- Kubernetes Monitoring

The goal wasn't simply making Terraform work.

The goal was understanding **why production infrastructure is designed the way it is.**

---

# ⭐ Highlights

- Built entirely using Terraform
- Production-inspired AWS Networking
- Infrastructure as Code
- Self-managed Multi-Node Kubernetes (k3s) Cluster
- Docker Image Pipeline
- GitHub Actions CI/CD
- Dedicated Kubernetes Control Plane
- Auto Scaling Worker Nodes
- External Application Load Balancer
- Kubernetes Ingress
- Amazon RDS PostgreSQL
- Redis StatefulSet
- CloudWatch Monitoring
- Prometheus Monitoring
- Grafana Monitoring Dashboards
- Prometheus ServiceMonitors
- Application Metrics Collection
- Kubernetes Metrics Monitoring
- Infrastructure Metrics Monitoring
- Remote Terraform State
- Automated EC2 Bootstrapping using User Data
- SSM-based Cluster Join Automation
- Separate Frontend & Backend Deployments
- Namespace Isolation
- Resource Requests & Limits
- Liveness & Readiness Probes

---

# 🏗 Architecture

```text
                 Internet
                     │
                     ▼
      External Application Load Balancer
                     │
                     ▼
            Kubernetes Ingress
                     │
                     ▼
     Multi-Node Kubernetes (k3s) Cluster
                     │
        ┌────────────┴────────────┐
        ▼                         ▼
 Frontend Deployment      Backend Deployment
        │                         │
        └───────────┬─────────────┘
                    ▼
            Redis StatefulSet
                    │
                    ▼
         Amazon RDS PostgreSQL


              Monitoring Layer
                     │
          ┌──────────┴──────────┐
          ▼                     ▼
      Prometheus              Grafana
          │                     │
          │              Monitoring Dashboards
          │
     ServiceMonitors
          │
   ┌──────┴─────────┐
   ▼                ▼
Frontend Metrics  Backend Metrics
```

# ☁ Infrastructure Components

| Service             | Purpose                 |
| ------------------- | ----------------------- |
| VPC                 | Network Isolation       |
| Public Subnets      | Load Balancer & Bastion |
| Application Subnets | Worker Nodes            |
| Database Subnets    | PostgreSQL              |
| Internet Gateway    | Public Connectivity     |
| NAT Gateway         | Private Internet Access |
| Security Groups     | Network Security        |
| Bastion Host        | Secure SSH              |
| External ALB        | Public Entry            |
| Control Plane       | Kubernetes API          |
| Worker ASG           | Kubernetes Workers      |
| IAM                 | Secure AWS Permissions  |
| SSM Parameter Store | Cluster Join Token      |
| RDS PostgreSQL      | Database                |
| Redis               | Cache                   |
| Kubernetes          | Orchestration           |
| Ingress             | Traffic Routing         |
| ConfigMaps          | Runtime Config          |
| Prometheus          | Metrics Collection & Monitoring |
| Grafana             | Metrics Visualization & Dashboards |
| ServiceMonitor      | Kubernetes Service Metrics Discovery |

---

# 🚀 Features

- Infrastructure as Code
- Automated Infrastructure Provisioning
- Self-managed Kubernetes Cluster
- Auto Scaling Workers
- Docker Image Automation
- GitHub Actions CI/CD
- Kubernetes Ingress
- Frontend & Backend Deployments
- Redis StatefulSet
- PostgreSQL
- ConfigMaps
- Namespace Isolation
- Health Checks
- CloudWatch Monitoring
- Prometheus Monitoring
- Grafana Dashboards
- Kubernetes ServiceMonitors
- Application Metrics
- Infrastructure Metrics
- Kubernetes Metrics
- Prometheus Target Monitoring

---

# 📊 Monitoring & Observability

The project has been extended with a dedicated monitoring stack using Prometheus and Grafana.

## Prometheus

Prometheus is used to collect and monitor metrics from the Kubernetes-based application and infrastructure.

The monitoring setup includes:

- Application metrics
- Frontend metrics
- Backend metrics
- Kubernetes metrics
- Node metrics
- Pod metrics
- Prometheus target health
- Scrape duration
- Target uptime
- CPU utilization
- Memory utilization
- Disk utilization
- Network traffic
- Pod restart counts
- Pending pod detection
- HTTP 5xx errors
- Error percentage
- Request rate
- Request latency
- Active requests

## ServiceMonitors

Kubernetes `ServiceMonitor` resources are used to configure Prometheus to discover and scrape application metrics.

The frontend and backend services expose metrics endpoints which are discovered by Prometheus through their corresponding ServiceMonitor resources.

This allows monitoring configuration to remain Kubernetes-native instead of manually configuring individual Prometheus scrape targets.

## Grafana

Grafana is used to visualize the collected Prometheus metrics through a custom monitoring dashboard.

The dashboard is organized into multiple sections:

### General

- Request Rate
- Request Latency
- Active Requests
- Total 5xx Errors
- Error Percentage
- Unhealthy Targets
- Healthy Target Ratio

### Infrastructure Status

- Frontend CPU Utilization
- Backend CPU Utilization
- Node CPU
- Frontend Memory Usage
- Backend Memory Usage
- Node Memory
- Node Disk Usage

### Kubernetes Status

- Pending Pods
- Frontend Pod Restarts
- Backend Pod Restarts
- Pod Status
- Receiving Network Traffic
- Transmitting Network Traffic

### Prometheus Status

- Scrape Duration
- Target Uptime

The monitoring setup was also tested by intentionally generating application errors and verifying that the corresponding metrics and dashboard panels reflected the failures correctly.

---

# 🛠 Technology Stack

| Category      | Technologies      |
| ------------- | ----------------- |
| Cloud         | AWS               |
| IaC           | Terraform         |
| Programming   | Python            |
| Containers    | Docker            |
| Orchestration | Kubernetes (k3s)  |
| CI/CD         | GitHub Actions    |
| Database      | PostgreSQL, Redis |
| Networking    | VPC, ALB, Ingress |
| Monitoring    | Prometheus, Grafana, ServiceMonitor, CloudWatch |

---

# 📂 Repository Structure

```text
aws-three-tier-architecture/

├── .github/
│   └── workflows/

├── docs/
│   ├── architecture.md
│   ├── deployment_notes.md
│   ├── design-decisions.md
│   ├── lessons_learned.md
│   └── roadmap.md

├── Backend/
│   ├── app.py
│   ├── requirement.txt
│   └── Dockerfile

├── Frontend/
│   ├── app.py
│   ├── requirement.txt
│   └── Dockerfile

├── kubernetes-files/
│   ├── base/
│   ├── backend/
│   ├── frontend/
│   ├── redis/
│   ├── monitoring/
│   └── ingress.yaml

├── images/
│   ├── architecture.png
│   ├── Infrastructure_status.png
│   ├── Kubernetes_status.png
│   ├── Application_status.png
│   └── Prometheus_status.png

├── monitoring/
│   ├── backend-servicemonitor.yml
│   ├── frontend-servicemonitor.yml
│   ├── deployment.yml
│   ├── namespace.yml
│   ├── service.yml
│   ├── prometheus.yml
│   └── grafana_dashboard.json


├── terraform_infra/
│   └── scripts/

├── docker-compose.yml

├── README.md

└── LICENSE
```

---

# 🚧 Roadmap

## ✅ Version 1

- Terraform
- Docker
- GitHub Actions
- ALB
- RDS

## ✅ Version 2

- Kubernetes
- StatefulSets
- ConfigMaps
- Namespace
- Health Probes

## ✅ Version 2.1

- Ingress

## ✅ Version 3

- Single Multi-node Cluster
- Control Plane
- Worker ASG
- SSM Cluster Join
- Separate Frontend & Backend
- Internal Service Discovery

## ✅ Version 4

- Prometheus
- Application Metrics
- Kubernetes Metrics
- Infrastructure Metrics
- Prometheus Target Monitoring
- CPU & Memory Monitoring
- Network Monitoring
- Pod Monitoring
- Error Monitoring
- Request Rate Monitoring
- Latency Monitoring

## ✅ Version 4.1

- Grafana
- Custom Grafana Monitoring Dashboard
- Prometheus ServiceMonitors
- Frontend Metrics Monitoring
- Backend Metrics Monitoring
- Kubernetes Status Dashboard
- Infrastructure Status Dashboard
- Prometheus Status Dashboard
- 5xx Error Monitoring
- Error Percentage Monitoring
- Pod Restart Monitoring
- Pending Pod Monitoring
- Target Health Monitoring

## 🚀 Future

- Centralized Logging with Loki
- EKS
- ArgoCD
- HPA
- Metrics Server
- Cluster Autoscaler
- Distributed Tracing
- OpenTelemetry

---

## Architecture

---

## 🤝 Acknowledgements

The initial AWS architecture was inspired by publicly available cloud architecture tutorials. The Kubernetes architecture, automation, debugging, design decisions and production evolution represent my own implementation.

---

## Thanks for visiting my project! ⭐