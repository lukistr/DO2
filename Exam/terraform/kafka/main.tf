terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_network" "net-docker" {
  name = "appnet"
}

resource "docker_image" "img-zookeeper" {
  name = "bitnami/zookeeper:latest"
}

resource "docker_image" "img-kafka" {
  name       = "bitnami/kafka:latest"
  depends_on = [docker_image.img-zookeeper]
}

resource "docker_container" "zookeeper" {
  name  = "zookeeper"
  image = docker_image.img-zookeeper.image_id
  env   = ["ALLOW_ANONYMOUS_LOGIN=yes"]
  ports {
    internal = 2181
    external = 2181
  }
  networks_advanced {
    name = "appnet"
  }
}

resource "docker_container" "kafka" {
  name  = "kafka"
  image = docker_image.img-kafka.image_id
  env = ["KAFKA_BROKER_ID=1",
    "KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181",
    "ALLOW_PLAINTEXT_LISTENER=YES"]
  ports {
    internal = 9092
    external = 9092
  }
  networks_advanced {
    name = "appnet"
  }
  depends_on = [
    docker_container.zookeeper
  ]
}