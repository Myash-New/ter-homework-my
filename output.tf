output "vm_list" {
  value = concat(
    [
      for vm in yandex_compute_instance.web :
      {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
    [
      for vm in values(yandex_compute_instance.db) :
      {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ],
  [
      for vm in yandex_compute_instance.storage :
      {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ]
  )
}
output "my_image_id" {
  value = data.yandex_compute_image.my_image.id
}