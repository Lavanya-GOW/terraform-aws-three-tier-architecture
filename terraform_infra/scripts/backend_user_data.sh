#!/bin/bash
set -e
exec > /var/log/user-data.log 2>&1

date

ip addr

ip route

nslookup security.ubuntu.com

curl http://security.ubuntu.com

sleep 60

curl http://security.ubuntu.com

echo "Waiting for apt repositories..."

until sudo apt update; do
    echo "apt update failed. Retrying in 10 seconds..."
    sleep 10
done

sudo apt upgrade -y
sudo apt install docker.io -y
sudo apt install git -y

sudo mkdir -p /usr/local/lib/docker/cli-plugins

sudo curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 \
-o /usr/local/lib/docker/cli-plugins/docker-compose

sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

sudo systemctl start docker
sudo systemctl enable docker

until docker info >/dev/null 2>&1
do
    echo "Waiting for Docker daemon..."
    sleep 2
done

sudo usermod -aG docker ubuntu

cd /home/ubuntu

git clone https://github.com/Lavanya-GOW/terraform-aws-three-tier-architecture

cd /home/ubuntu/terraform-aws-three-tier-architecture

docker --version

HOST_PORT=8080 docker compose up -d --build