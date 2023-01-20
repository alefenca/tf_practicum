variable "image_tag" {
  type = string
}

source "yandex" "nginx" {
  disk_type           = "network-ssd"
  folder_id           = "b1g5rgf4frol5fakpmv1"
  image_description   = "my custom centos with nginx"
  image_family        = "centos-web-server"
  image_name          = "nginx-${var.image_tag}"
  source_image_family = "centos-7"
  ssh_username        = "centos"
  subnet_id           = "e9b2u8t1c02cdkh02df0"
  token               = ""
  use_ipv4_nat        = true
  zone                = "ru-central1-a"
}
build {
  sources = ["source.yandex.nginx"]
  provisioner "ansible" {
    user = "centos"
    playbook_file = "ansible/playbook.yml"
  }
}