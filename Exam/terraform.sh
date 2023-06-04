#!/bin/bash

echo "* Install terraform ..."
wget https://releases.hashicorp.com/terraform/1.4.6/terraform_1.4.6_linux_amd64.zip
unzip terraform_1.4.6_linux_amd64.zip
mv terraform /usr/local/bin

sleep 10s

echo "* Copy terraform folders ..."
cp -R /vagrant/terraform/* /home/vagrant/

echo "* Terraform init kafka ..."
cd /home/vagrant/kafka
terraform init

echo "* Terraform apply kafka ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init exporter ..."
cd /home/vagrant/exporter
terraform init

echo "* Terraform apply exporter ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init apps ..."
cd /home/vagrant/apps
terraform init

echo "* Terraform apply apps ..."
echo "yes" | terraform apply

sleep 10s

echo "* Terraform init monitoring ..."
cd /home/vagrant/monitoring
terraform init

echo "* Terraform apply monitoring ..."
echo "yes" | terraform apply

sleep 20s
docker logs kafka-discoverer
docker logs kafka-observer