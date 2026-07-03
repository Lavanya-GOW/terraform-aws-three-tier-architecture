<div align="center">

# ☁️ AWS Three-Tier Architecture

### Production-Inspired Infrastructure on AWS using Terraform, Docker & GitHub Actions

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazonaws)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions)
![License](https://img.shields.io/badge/License-MIT-success?style=for-the-badge)

Production-inspired AWS Infrastructure demonstrating Infrastructure as Code, CI/CD, Dockerized deployments and scalable cloud architecture.

</div>

---

# 📖 Overview

This project demonstrates how a production-inspired cloud infrastructure can be designed, deployed and managed entirely through Infrastructure as Code.

Rather than creating isolated AWS resources, the objective was to understand how networking, compute, security, automation, databases and deployment pipelines work together as a complete platform.

The infrastructure provisions an end-to-end AWS environment capable of automatically deploying Dockerized applications using Terraform, GitHub Actions and EC2 User Data.

---

# 🎯 Why I Built This

The primary objective of this project was to move beyond learning individual AWS services and instead understand how production systems are actually engineered.

This repository focuses on:

- Infrastructure as Code
- Production networking
- Automation
- CI/CD
- Dockerized deployments
- High Availability
- Cloud debugging
- Infrastructure troubleshooting

The goal wasn't simply making Terraform work.

The goal was understanding **why production infrastructure is designed the way it is.**

---

# ⭐ Highlights

- Built entirely using Terraform
- Production-inspired AWS Networking
- Infrastructure as Code
- Dockerized Flask Application
- GitHub Actions CI/CD
- Auto Scaling Groups
- External & Internal Load Balancers
- Bastion Host
- Amazon RDS PostgreSQL
- CloudWatch Monitoring
- Remote Terraform State
- Automated EC2 Bootstrapping using User Data
- Multi Availability Zone deployment

---

# 🏗 Architecture

```

Internet

│

▼

External Application Load Balancer

│

├───────────────┐

▼ ▼

Frontend ASG Frontend ASG

│

▼

Internal Application Load Balancer

│

├───────────────┐

▼ ▼

Backend ASG Backend ASG

│

▼

Amazon RDS PostgreSQL

```

Every component is deployed inside a custom VPC distributed across multiple Availability Zones.

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

---

# 🚀 Features

- Infrastructure as Code
- Dockerized Application Deployment
- Automated EC2 Bootstrapping
- Auto Scaling
- Internal Load Balancing
- External Load Balancing
- Bastion Host
- Private Networking
- PostgreSQL Database
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
| Container Orchestration | Docker Compose |
| CI/CD | GitHub Actions |
| Database | PostgreSQL |
| Networking | VPC, ALB, NAT Gateway |
| Monitoring | CloudWatch |
| Version Control | Git & GitHub |

---

# 📂 Repository Structure

```

aws-three-tier-architecture/

├── .github/
│ └── workflows/

├── docs/
│ ├── architecture.md
│ ├── deployment_notes.md
│ ├── design-decisions.md
│ ├── lessons_learned.md
│ └── roadmap.md

├── images/
  └── architecture.png

├── terraform_infra/
  └──scripts/

├── Dockerfile

├── docker-compose.yml

├── app.py

├── requirements.txt

├── README.md

└── LICENSE

```

---

## Architecture

<p align="center">

<img src="images/architecture.png" width="1000"/>

</p>
---

## Thanks for visiting my project!
