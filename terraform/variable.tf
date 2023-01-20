variable "image_id" {
  default = "fd82tb3u07rkdkfte3dn"
  type = string
  description = "Image id"
}
variable "resources" {
  type = object({
    disk = number
    memory = number
    cpu = number
  })
  description = "Resource limit for VM"
}
variable "cidr_blocks" {
  type = list(list(string))
  description = "List of ip ranges"
}

variable "az" {
  type = list(string)
  default = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c"
  ]
}

variable "vm_count" {
  type = string
  description = "VM count"
}

variable "image_name" {
  type = string
  default = ""
  description = "Image name"
}

variable "image_tag" {
  type = number
  default = 0
  description = "Tag for image"
}