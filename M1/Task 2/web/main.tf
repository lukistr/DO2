terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 5
}

resource "null_resource" "files" {
  connection {
    type     = "ssh"
    user     = "vagrant"
    password = "vagrant"
    host     = "192.168.100.101"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /project || true",
      "sudo mkdir /project || true",
      "cd /project",
      "sudo git clone https://github.com/shekeriev/bgapp",
      "sudo cp /project/bgapp/web/* /var/www/html",
    ]
  }
}