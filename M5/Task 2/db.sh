#/bin/bash

echo "* Add hosts ..."
echo "192.168.100.201 web.do2.lab web" | sudo tee /etc/hosts
echo "192.168.100.202 db.do2.lab db" | sudo tee /etc/hosts

echo "* Install pupet agent ..."
sudo dnf -y install https://yum.puppet.com/puppet-release-el-8.noarch.rpm
sudo dnf update -y