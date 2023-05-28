terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

resource "docker_image" "img-prometheus" {
  name       = "prom/prometheus"
#  depends_on = [docker_image.img-kafka-cons]
}

resource "docker_image" "img-grafana" {
  name       = "grafana/grafana"
  depends_on = [docker_image.img-prometheus]
}

resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = docker_image.img-prometheus.image_id
  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = "exam-prep"
  }
  volumes {
    host_path      = "/vagrant/terraform/monitoring/prometheus.yml"
    container_path = "/etc/prometheus/prometheus.yml"
    read_only      = true
  }
#  depends_on = [docker_container.kafka-consumer]
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = docker_image.img-grafana.image_id
  env   = ["ALLOW_ANONYMOUS_LOGIN=yes"]
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = "exam-prep"
  }
  volumes {
    host_path      = "/vagrant/terraform/monitoring/datasource.yml"
    container_path = "/etc/grafana/provisioning/datasources/datasource.yml"
    read_only      = true
  }
  depends_on = [docker_container.prometheus]
}