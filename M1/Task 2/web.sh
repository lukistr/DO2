#!/bin/bash

echo "* Add hosts ..."
echo "192.168.100.101 web" >> /etc/hosts
echo "192.168.100.102 db" >> /etc/hosts

echo "* Install Software ..."
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 php php-mysql -y
sudo rm /var/www/html/index.html

echo "* Start HTTP ..."
sudo systemctl enable apache2
sudo systemctl start apache2
sudo systemctl restart apache2

echo "* Firewall - open port 80 ..."
sudo ufw allow "Apache Full"
sudo ufw disable && sudo ufw enable