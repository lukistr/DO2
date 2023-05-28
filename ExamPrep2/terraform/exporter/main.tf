terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "img-exporter" {
  name = "danielqsj/kafka-exporter"
  #depends_on = [docker_image.img-kafka]
}

resource "docker_container" "exporter" {
  name  = "exporter"
  image = docker_image.img-exporter.image_id
  env   = ["kafka.server=kafka:9092"]
  ports {
    internal = 9308
    external = 9308
  }
  networks_advanced {
    name = "exam-prep"
  }
  #depends_on = [docker_container.kafka]
}