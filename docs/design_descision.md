# Design Decisions

## Why Terraform?

Terraform was selected because Infrastructure as Code enables reproducible deployments, version control, automation and collaboration.

---

## Why Docker?

Docker provides consistent runtime environments across development and production.

---

## Why Auto Scaling Groups?

Instead of manually creating EC2 instances, Auto Scaling Groups improve availability and automatically replace unhealthy instances.

---

## Why Two Load Balancers?

An external Application Load Balancer exposes the frontend securely.

An internal Application Load Balancer isolates backend services and prevents direct public access.

---

## Why Remote State?

Terraform Remote State enables collaboration while preventing state corruption.

---

## Why User Data?

User Data automatically bootstraps EC2 instances, eliminating manual SSH configuration after deployment.

---

## Why GitHub Actions?

GitHub Actions automates image builds, infrastructure validation and deployment pipelines.

---

## Future Design Improvements

- Amazon EKS
- Helm Charts
- GitOps
- Service Mesh
- Blue/Green Deployments
