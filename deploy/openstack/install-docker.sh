#!/usr/bin/env bash

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    git-core

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get -y update
sudo apt-get install -y docker-ce

# Post-install
sudo usermod -aG docker $USER

sudo systemctl stop docker
sudo bash -c 'cat << EOF > /etc/docker/daemon.json
{
    "mtu": 1450
}
EOF'
sudo cat /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl restart docker
