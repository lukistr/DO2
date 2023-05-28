#/bin/bash

echo '* Add hosts ...'
echo '192.168.100.201   server.do2.lab   server' | sudo tee -a /etc/hosts
echo '192.168.100.202   cliant.do2.lab   cliant' | sudo tee -a /etc/hosts

echo '* Install needed software for docker ...'
sudo apt update
sudo apt install -y ca-certificates curl gnupg python3 python3-pip python3-distro openjdk-17-jre

echo '* Open firewall ports ...'
sudo ufw disable
#sudo ufw allow 9092
#sudo ufw allow 9308
#sudo ufw reload

echo '* Add docker key ...'
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo '* Set the repository ...'
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo '* Install docker ...'
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo '* Add vagrant user to docker group ...'
usermod -aG docker vagrant

echo '* Download Apache Kafka ...'
wget -q https://downloads.apache.org/kafka/3.3.2/kafka_2.13-3.3.2.tgz
tar xzvf kafka_2.13-3.3.2.tgz
mv ./kafka_2.13-3.3.2 ./kafka

echo '* Start Zookeeper and Apache Kafka ...'
kafka/bin/zookeeper-server-start.sh -daemon kafka/config/zookeeper.properties
kafka/bin/kafka-server-start.sh -daemon kafka/config/server.properties

echo '* Start Kafka Exporter ...'
sudo docker run -d --rm -p 9308:9308 danielqsj/kafka-exporter --kafka.server=192.168.100.201:9092

echo '* Install Kafka Python library ...'
sudo pip3 install kafka-python

echo '* Create 3 partition with one replica ...'
kafka/bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 3 --topic homework

echo '* Start the producer ...'
python3 /vagrant/kafka/producer.py &> /home/vagrant/producer.log &

echo '* Start the consumer ...'
python3 /vagrant/kafka/consumer-subscribe.py &> /home/vagrant/consumer.log &