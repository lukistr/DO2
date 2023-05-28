#/bin/bash

echo "* Add hosts ..."
echo "192.168.100.201 web.do2.lab web" | sudo tee /etc/hosts
echo "192.168.100.202 db.do2.lab db" | sudo tee /etc/hosts

echo "* Allow ports 80 and 8080 ..."
sudo ufw allow 8080
sudo ufw allow 80
sudo ufw allow 3306
sudo ufw reload

echo "* Install pupet ..."
sudo apt update
sudo apt install -y ntp puppet