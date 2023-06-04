#!/bin/bash

echo "* Open Grafana ports ..."
sudo ufw allow 3000
echo "* Open Promerheus ports ..."
sudo ufw allow 9090
echo "* Open Kafka-exporter ports ..."
sudo ufw allow 9308
echo "* Reload firewall settings ..."
sudo ufw reload

echo "* Install puppet and docker module ..."
sudo apt install -y puppet
puppet module install puppetlabs-docker
puppet module install puppetlabs-vcsrepo