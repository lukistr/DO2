#/bin/bash

echo '* Add hosts ...'
echo '192.168.100.201   server.do2.lab   server' | sudo tee -a /etc/hosts
echo '192.168.100.202   cliant.do2.lab   cliant' | sudo tee -a /etc/hosts

echo '* Turn off firewall ...'
sudo ufw disable

echo '* Download Prometheus ...'
wget -q https://github.com/prometheus/prometheus/releases/download/v2.41.0/prometheus-2.41.0.linux-amd64.tar.gz
tar xzvf prometheus-2.41.0.linux-amd64.tar.gz

echo '* Start Prometheus ...'
prometheus-2.41.0.linux-amd64/prometheus --config.file /vagrant/config/prometheus.yml --web.enable-lifecycle &> /tmp/prometheus.log &

echo '* Download key ...'
sudo apt install -y apt-transport-https software-properties-common wget
sudo wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key

echo '* Add repository ...'
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

echo '* Install Grafana ...'
sudo apt update
sudo apt install -y grafana

echo '* Copy configuration ...'
sudo cp /vagrant/config/datasource.yml /etc/grafana/provisioning/datasources/datasource.yaml

echo '* Start Grafana ...'
sudo systemctl daemon-reload
sudo systemctl enable --now grafana-server