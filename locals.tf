locals {
  ssh_public_key = file("~/sshkey_terrafrom.pub")
}

#locals {
#  db_vms = {
#    "main" = {
#      image_id = data.yandex_compute_image.my_image.id  
#    },
#    "replica" = {
#      image_id = data.yandex_compute_image.my_image.id 
#    }
#  }
#}