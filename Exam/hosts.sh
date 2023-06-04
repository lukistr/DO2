#!/bin/bash

echo "* Update the system ..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release tar bzip2 wget openjdk-17-jre groovy git tree ntp unzip

echo "* Install needed softwares ..."
sudo apt install -y python3 python3-pip python3-distro
pip3 install docker