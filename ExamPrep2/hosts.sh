#!/bin/bash

#echo "* Add hosts ..."
#echo "192.168.100.101 server.do2.exam server" | sudo tee >> /etc/hosts
#echo "192.168.100.102 web.do2.exam web" | sudo tee >> /etc/hosts
#echo "192.168.100.103 db.do2.exam db" | sudo tee >> /etc/hosts

echo "* Update the system ..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release tar bzip2 wget openjdk-17-jre groovy git tree ntp unzip