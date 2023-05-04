output "container-web" {
  value = docker_container.con-web.id
}

output "container-db" { 
  value = docker_container.con-db.id
}