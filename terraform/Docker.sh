#!/bin/bash
sudo yum update -y
yum install docker -y
sudo systemctl start docker
sudo usermod -aG docker ec2-user
sudo gpasswd -a $USER docker
cd /tmp && curl -sLo kind https://kind.sigs.k8s.io/dl/v0.11.0/kind-linux-amd64 && sudo install -o root -g root -m 0755 kind /usr/local/bin/kind
cd /tmp && curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  image: kindest/node:v1.19.11@sha256:07db187ae84b4b7de440a73886f008cf903fcf5764ba8106a9fd5243d6f32729
  extraPortMappings:
  - containerPort: 30000
    hostPort: 30000
  - containerPort: 30001
    hostPort: 30001" > /tmp/kind.yaml
sudo systemctl restart docker