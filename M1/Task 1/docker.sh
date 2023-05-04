#!/bin/bash

sudo apt update && sudo apt upgrade -y

echo "* Add hosts ..."
echo "192.168.100.101 web" >> /etc/hosts
echo "192.168.100.102 db" >> /etc/hosts

echo "* Add Docker official GPG key ..."
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "* Set up the repository ..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
echo "* Add read permision for docker.gpg ..."
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo "* Install Docker ..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "* Firewall - open port 80 ..."
sudo ufw allow 80
sudo ufw allow 2375
sudo ufw disable && sudo ufw --force enable

echo "* Add user vagrant to docker ..."
usermod -aG docker vagrant

echo "* Adjust Docker configuration ..."
sed -i 's@-H fd://@-H fd:// -H tcp://0.0.0.0@g' /lib/systemd/system/docker.service

echo "* Start Docker service"
sudo systemctl daemon-reload
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl restart docker