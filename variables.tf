###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "web_instance_count" {
  type        = number
  default     = 2
}

variable "web_instance_name" {
  type        = string
  default     = "web"
}

variable "web_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "web_cores" {
  type        = number
  default     = 2
}

variable "web_memory" {
  type        = number
  default     = 2
}

variable "web_core_fraction" {
  type        = number
  default     = 20
}

#variable "image_id" {
#  type        = string
#  default     = "fd84b1mojb8650b9luqd"
#}

data "yandex_compute_image" "my_image" {
  family = "ubuntu-2204-lts"
  folder_id = "standard-images"
}

variable "db_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "db_vms" {
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = optional(number, 20)
    nat           = optional(bool, true)
    image_id      = optional(string)
    zone          = optional(string, "ru-central1-a")
    labels        = optional(map(string), {})
    metadata      = optional(map(string), {})
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 4
      ram           = 8
      disk_volume   = 20
      core_fraction = 50
      nat           = true
    },
    {
      vm_name       = "replica"
      cpu           = 2
      ram           = 4
      disk_volume   = 10
      core_fraction = 20
      nat           = true
    }
  ]
}
variable "vms_ssh_root_key" {
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDk4/+bLOZvAX1LH+uQDvG4RrQNFquSpO43XIWyZ0P95nar43cCEQ1fT58bXcJbtuxTLmf8ifKUIS1lQcR11eNTkSKhKHlgFGEhF+urLBkrI4rKRJtdt3Q0xUG1zTXs3FeHkU65PxXzDsmqI8UEWqBcNsn0CrPHhWO6OwjfCNUmHHgRudEn3QRndq6djQWWs4+3FgcEhuzPiXLES/ma66mTUmd+ApuGSEwXScBysWQIaW5t1wKB+sGq26V/Vt9jWMu05dQWAHqf/JjsXd+vV6ygjnSLiei60D/KCURqsxAsAlk1f3iGiMFtQVm1XPpRrzwU8E7QcgYFL8w8xYkAofR9B9uN30Ni23pCfxyGTakh1B32cOzHNps5ZGJ7rEdOCj/f1rpz9b6mMw2ExrbBJYtKcCCwBlqcU6pTDqxU0QGpDpIpV66BasDnKE6ZZeGO1WpXm5EoOXwFzLilvNpwxQMl04U0WQidS5wbjaoU15yfNLHmG0BKXQal8aZB6xoWudc="
  description = "ssh-keygen -t ed25519"
}

variable "storage_instance_name" {
  type        = string
  default     = "storage"
}

variable "storage_platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "storage_cores" {
  type        = number
  default     = 2
}

variable "storage_memory" {
  type        = number
  default     = 1
}

variable "storage_core_fraction" {
  type        = number
  default     = 20
}

variable "disk_instance_count" {
  type        = number
  default     = 3
}

variable "disk_instance_size" {
  type        = number
  default     = 1
}