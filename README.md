# ☁️ AWS Three Tier Architecture

A production-inspired three-tier architecture deployed on AWS using Terraform, Docker and GitHub Actions.

---

## 🚀 Features

- Infrastructure as Code using Terraform
- Dockerized Flask Application
- GitHub Actions CI/CD
- Auto Scaling Groups
- Application Load Balancers
- Bastion Host
- Amazon RDS PostgreSQL
- High Availability across Multiple Availability Zones
- Remote Terraform State
- CloudWatch Monitoring
- Secure Networking

## 🛠️ Tech Stack

| Category | Technologies |
|----------|--------------|
| Cloud | AWS |
| IaC | Terraform |
| Containers | Docker |
| CI/CD | GitHub Actions |
| Language | Python |
| Database | PostgreSQL |
| Networking | VPC, NAT Gateway, ALB |
| Compute | EC2, Auto Scaling |


## 🏗️ Architecture

The infrastructure follows a production-inspired three-tier architecture.

Client

↓

External Application Load Balancer

↓

Frontend Auto Scaling Group

↓

Internal Application Load Balancer

↓

Backend Auto Scaling Group

↓

Amazon RDS PostgreSQL

All resources are deployed inside a custom VPC distributed across multiple Availability Zones.


## 🚀 Deployment

Clone Repository

```bash
git clone <repo>
```

Build Docker

```bash
docker compose up -d
```

Terraform

```bash
terraform init

terraform plan

terraform apply
```

Destroy

```bash
terraform destroy
```

## ⚙️ CI/CD

GitHub Actions automates:

- Docker Image Build
- DockerHub Push
- Terraform Validation
- Terraform Plan
- Terraform Apply (Manual trigger)
- Terraform Destroy (Manual trigger)

## 📚 Lessons Learned

During this project I gained practical experience with:

- Terraform debugging
- Cloud-init troubleshooting
- User-data execution
- Docker deployment
- Auto Scaling Groups
- Application Load Balancers
- Target Group Health Checks
- AWS Networking
- CI/CD automation

## 🚀 Future Improvements

- Deploy on Amazon EKS
- Helm Charts
- GitOps using ArgoCD
- Monitoring with Prometheus
- Grafana Dashboards
- Blue/Green Deployments

## 👨‍💻 Author

Lavanya Sharma

Electrical Engineering Undergraduate @ IIT Jammu

Interested in Cloud Computing, DevOps and Platform Engineering.