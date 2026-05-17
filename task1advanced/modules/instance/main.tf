locals {
  instance_ssh-keys = "${var.instance_user}:${file("~/.ssh/id_rsa.pub")}"
}


data "yandex_compute_image" "image" {
  family = var.instance_image_family
}

resource "yandex_compute_disk" "disk" {
  name = var.instance_disk_name
  type = var.instance_disk_type
  zone = var.instance_zone
  image_id = data.yandex_compute_image.image.image_id
  size = var.instance_disk_size
}

resource "yandex_compute_instance" "instance" {
  name = var.instance_name
  zone = var.instance_zone

  resources {
    cores  = var.instance_cores
    memory = var.instance_memory
  }

  boot_disk {
    disk_id = yandex_compute_disk.disk.id
  }

  network_interface {
    subnet_id = var.instance_subnet_id
    nat       = var.instance_nat
  }

  metadata = {
    ssh-keys = local.instance_ssh-keys
  }
}