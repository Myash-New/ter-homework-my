
resource "local_file" "ansible_inventory" {
  filename = "${path.module}/ansible_inventory"
  content  = templatefile("${path.module}/ansible_inventory_file.tpl", {
    webservers = [
      for vm in yandex_compute_instance.web : {
        vm_name     = vm.name
        external_ip = vm.network_interface[0].nat_ip_address
        fqdn        = vm.fqdn
      }
    ]
    databases = [
      for vm in yandex_compute_instance.db : {
        vm_name     = vm.name
        external_ip = vm.network_interface[0].nat_ip_address
        fqdn        = vm.fqdn
      }  
    ]

    storages = [
       for vm in [yandex_compute_instance.storage] : {
        vm_name     = vm.name
        external_ip = vm.network_interface[0].nat_ip_address
        fqdn        = vm.fqdn
      }]
   })
 
  depends_on = [
    yandex_compute_instance.web,
    yandex_compute_instance.db,
    yandex_compute_instance.storage
  ]
}