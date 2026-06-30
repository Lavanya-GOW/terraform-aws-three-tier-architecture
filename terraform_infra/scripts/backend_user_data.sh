#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1
sudo apt update && sudo apt upgrade -y
sudo apt install docker.io -y
sudo apt install git -y
sudo mkdir -p /usr/local/lib/docker/cli-plugins && sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o /usr/local/lib/docker/cli-plugins/docker-compose && sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose
sudo systemctl start docker
sudo systemctl enable docker
usermod -aG docker ubuntu
cd /home/ubuntu
git clone https://github.com/Lavanya-GOW/terraform-aws-three-tier-architecture
cd /home/ubuntu/terraform-aws-three-tier-architecture
docker --version
sed -i "s/^IMAGE_TAG=.*/IMAGE_TAG=latest" .env
docker compose pull
docker compose up -d