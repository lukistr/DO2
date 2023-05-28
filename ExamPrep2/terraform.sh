#!/bin/bash

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

sleep 30s
docker logs kafka-consumer
docker logs kafka-producer