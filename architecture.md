# Infrastructure Architecture

## Components

### Networking

- VPC
- Internet Gateway
- NAT Gateway
- Elastic IP
- Public Subnet
- Frontend Private Subnets
- Backend Private Subnets
- Database Private Subnets
- Route Tables

---

### Security

- Security Groups
- IAM Roles
- IAM Instance Profiles
- Bastion Host

---

### Compute

Frontend Layer

- Launch Template
- Auto Scaling Group
- Docker
- Flask

Backend Layer

- Launch Template
- Auto Scaling Group
- Docker
- Flask API

---

### Load Balancers

External ALB

Receives traffic from Internet

↓

Routes traffic to Frontend ASG

Internal ALB

Receives traffic from Frontend

↓

Routes traffic to Backend ASG

---

### Database

Amazon RDS PostgreSQL

Private Subnet

---

### CI/CD

GitHub

↓

GitHub Actions

↓

Docker Build

↓

DockerHub

↓

Terraform Apply

↓

EC2 User Data

↓

Docker Compose Pull

↓

Application Starts

---

## Request Flow

```
User

↓

External ALB

↓

Frontend ASG

↓

Internal ALB

↓

Backend ASG

↓

RDS
```

---

## Availability

- Multi Availability Zone
- Auto Scaling
- Health Checks
- Target Groups
- CloudWatch Monitoring

---

## Security

- Bastion Host
- Private EC2
- Private Database
- IAM Roles
- Security Groups
