resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.db_vms : vm.vm_name => vm }

  name        = each.key
  platform_id = var.db_platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
#     image_id  = each.value.image_id
      image_id  = data.yandex_compute_image.my_image.id
#     image_id  = try(each.value.image_id, data.yandex_compute_image.my_image.id)
      size      = each.value.disk_volume
    }
  }
  timeouts {
    create = "15m"
    delete = "15m"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.nat
  }

   metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }

  depends_on = [yandex_vpc_subnet.develop]
}
