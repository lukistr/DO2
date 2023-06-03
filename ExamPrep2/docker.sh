#!/bin/bash

echo "* Open Zookeeper ports ..."
sudo ufw allow 2181
echo "* Open Docker ports ..."
sudo ufw allow 2375
echo "* Open Grafana ports ..."
sudo ufw allow 3000
echo "* Open Promerheus ports ..."
sudo ufw allow 9090
echo "* Open Kafka ports ..."
sudo ufw allow 9092
echo "* Open Kafka-exporter ports ..."
sudo ufw allow 9308
echo "* Reload firewall settings ..."
sudo ufw reload

echo "* Install needed softwares ..."
sudo apt install -y python3 python3-pip python3-distro
pip3 install docker

echo "* Install terraform ..."
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
mv terraform /usr/local/bin

echo "* Install puppet and docker module ..."
sudo apt install -y puppet
puppet module install puppetlabs-docker
puppet module install puppetlabs-vcsrepo
