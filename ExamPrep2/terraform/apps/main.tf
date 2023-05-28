terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "img-kafka-prod" {
  name       = "shekeriev/kafka-prod"
#  depends_on = [docker_image.img-exporter]
}

resource "docker_image" "img-kafka-cons" {
  name       = "shekeriev/kafka-cons"
  depends_on = [docker_image.img-kafka-prod]
}

resource "docker_container" "kafka-producer" {
  name  = "kafka-producer"
  image = docker_image.img-kafka-prod.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=prep"]
  networks_advanced {
    name = "exam-prep"
  }
#  depends_on = [docker_container.exporter]
}

resource "docker_container" "kafka-consumer" {
  name  = "kafka-consumer"
  image = docker_image.img-kafka-cons.image_id
  env   = ["BROKER=kafka:9092", "TOPIC=prep"]
  networks_advanced {
    name = "exam-prep"
  }
  depends_on = [docker_container.kafka-producer]
}