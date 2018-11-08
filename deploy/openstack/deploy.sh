#!/usr/bin/env bash

# Script to install docker-compose and deploy database.
ip addr
# Download and install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
# clone repo and deploy
git clone https://github.com/COMBAT-TB/combatb-db.git
cd combatb-db
git checkout dev

sudo docker-compose up --build -d
