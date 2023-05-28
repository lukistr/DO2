#/bin/bash

echo "* Add hosts ..."
echo "192.168.100.201 docker.do2.lab docker" | sudo tee /etc/hosts

echo "* Allow ports 80 and 8080 ..."
sudo ufw allow 8080
sudo ufw allow 80
sudo ufw reload

echo "* Install pupet and docker class ..."
sudo apt update
sudo apt install -y ntp puppet
sudo puppet module install puppetlabs-docker