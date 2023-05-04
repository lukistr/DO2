#/bin/bash

#sudo apt update
#sudo apt install -y ca-certificates curl gnupg

#sudo install -m 0755 -d /etc/apt/keyrings
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
#sudo chmod a+r /etc/apt/keyrings/docker.gpg

#echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#sudo apt update
#sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#sudo usermod -aG docker vagrant

sudo ufw allow 8080
sudo ufw allow 80
sudo ufw reload

sudo apt install -y ntp git

#git config --global user.email "alabala@gmail.com"
#git config --global user.name "Ala Bala"

#echo 'eval "$(chef shell-init bash)"' >> ~/.bash_profile
#echo 'export PATH="/opt/chef-workstation/embedded/bin:$PATH"' >> ~/.bash_profile && source ~/.bash_profile

echo "* Install Chef Server ..."
wget -P /tmp https://packages.chef.io/files/stable/chef-server/15.6.2/ubuntu/22.04/chef-server-core_15.6.2-1_amd64.deb
sudo dpkg -i /tmp/chef-server-core_*.deb

echo "* Install Chef Workstation ..."
wget -P /tmp https://packages.chef.io/files/stable/chef-workstation/22.10.1013/ubuntu/20.04/chef-workstation_22.10.1013-1_amd64.deb
sudo dpkg -i /tmp/chef-workstation_*.deb

echo "* Configure Chef Server ..."
sudo chef-server-ctl reconfigure --chef-license accept

echo "* Generate Chef repository test ..."
mkdir cookbooks || true && cd cookbooks
sudo chef generate cookbook test --chef-license accept

echo "* Copy cookbooks files ..."
sudo cp /vagrant/cookbooks/test/recipes/default.rb /home/vagrant/cookbooks/test/recipes/default.rb
sudo cp /vagrant/cookbooks/test/metadata.rb /home/vagrant/cookbooks/test/metadata.rb
sudo cp /vagrant/solo.* /home/vagrant/cookbooks

echo "* Download docker cookbook ..."
knife supermarket download docker
tar xzvf docker-10.4.8.tar.gz

sudo chef-solo -c solo.rb -j solo.json