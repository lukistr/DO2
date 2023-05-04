#!/bin/bash

echo "* Add hosts ..."
echo "192.168.11.101 server.do2.lab server" | sudo tee /etc/hosts

echo "* Install Python 3 ..."
# sudo apt update && sudo apt upgrade -y
sudo apt install -y python3 python3-pip python3-distro

echo "* Create repository ..."
sudo curl -fsSL -o /etc/apt/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/SALT-PROJECT-GPG-PUBKEY-2023.gpg
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest jammy main" | sudo tee /etc/apt/sources.list.d/salt.list

echo "* Install Salt-master ..."
sudo apt update
sudo apt install -y salt-master salt-minion

echo "* Open firewall ports ..."
sudo ufw allow 4505
sudo ufw allow 4506
sudo ufw allow 80
sudo ufw allow 8080
sudo ufw disable && sudo ufw --force enable

echo "* Copy minion settings ..."
sudo cp /vagrant/salt/minion /etc/salt/minion

echo "* Copy top files ..."
sudo mkdir /srv/salt/
sudo cp /vagrant/salt/* /srv/salt/

sudo systemctl enable salt-master && sudo systemctl start salt-master
sudo systemctl restart salt-master
sudo systemctl restart salt-minion