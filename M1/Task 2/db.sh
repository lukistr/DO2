#!/bin/bash

echo "* Add hosts ..."
echo "192.168.100.101 web" >> /etc/hosts
echo "192.168.100.102 db" >> /etc/hosts

echo "* Install Software ..."
sudo apt update && sudo apt upgrade -y
sudo apt install mariadb-server -y

echo "* Start HTTP ..."
sudo systemctl start mariadb
sudo systemctl enable mariadb

echo "* Firewall - open port 3306 ..."
sudo ufw allow 3306
sudo ufw disable && sudo ufw enable

sudo sed -i.bak s/127.0.0.1/0.0.0.0/g /etc/mysql/mariadb.conf.d/50-server.cnf
sudo systemctl restart mariadb