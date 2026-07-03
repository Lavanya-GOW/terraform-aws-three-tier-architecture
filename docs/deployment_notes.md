# Deployment Notes

## Terraform

```
terraform fmt
terraform validate
terraform plan
terraform apply
```

---

## Docker Pipeline

Push to main branch.

Automatically

- Builds Docker Image
- Pushes to DockerHub
- Runs Smoke Test

---

## Terraform Pipeline

Automatically

- fmt
- validate
- plan

---

## Manual Deployment

Run

Terraform Apply

GitHub Workflow

---

## Manual Destroy

Run

Terraform Destroy

GitHub Workflow

---

## Important Lessons Learned

### Networking

Incorrect Route Table Associations caused

- NAT Failure
- apt update failures

---

### User Data

Cloud-init timing matters.

Modern Ubuntu images work much better.

---

### Docker

docker compose configuration must match

Frontend

```
80:5000
```

Backend

```
8080:5000
```

---

### ALBs

External

Frontend

Internal

Backend

---

### Health Checks

Frontend

```
/health
```

Backend

```
/health
```

---

### Common Debug Commands

Cloud Init

```
cloud-init status
```

User Data

```
cat /var/lib/cloud/instance/scripts/part-001
```

Docker

```
docker ps
```

Health

```
curl localhost:5000/health
```

Logs

```
journalctl -u docker
```

Cloud-init

```
cat /var/log/cloud-init.log
```

---

## Final Status

Infrastructure

✅ Healthy

ALBs

✅ Healthy

Target Groups

✅ Healthy

ASGs

✅ Healthy

Docker

✅ Healthy

Terraform

✅ Healthy

GitHub Actions

✅ Healthy
