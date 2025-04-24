resource "yandex_compute_disk" "disks" {
  count        = var.disk_instance_count
  name         = "disk-${count.index + 1}"
  size         = var.disk_instance_size
  type         = "network-hdd"
  zone         = var.default_zone
}

resource "yandex_compute_instance" "storage" {
  name        = var.storage_instance_name
  platform_id = var.storage_platform_id
  resources {
    cores         = var.storage_cores
    memory        = var.storage_memory
    core_fraction = var.storage_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image.id
    }  
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disks[*]
    content {
      disk_id = secondary_disk.value.id
    }
  }
}