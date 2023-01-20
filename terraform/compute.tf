/*data "yandex_compute_image" "this" {
  family = "centos-web-server"
}*/
data "yandex_compute_image" "this" {
  name       = var.image_name != "" && var.image_tag != 0 ? "${var.image_name}-${var.image_tag}" : "nginx-1"
}
resource "yandex_compute_instance_group" "this" {
  name = "ig-with-coi"
  folder_id = "b1g5rgf4frol5fakpmv1"
  service_account_id = yandex_iam_service_account.this.id
  instance_template {
    platform_id = "standard-v1"
    resources {
      cores  = var.resources.cpu
      memory = var.resources.memory
    }

    boot_disk {
      initialize_params {
#        image_id = "${var.image_id}"
        image_id = data.yandex_compute_image.this.id
        size = var.resources.disk
      }
    }

    network_interface {
      network_id = yandex_vpc_network.this.id
#      subnet_ids = ["yandex_vpc_subnet.this[""].id", "yandex_vpc_subnet.this[1].id", "yandex_vpc_subnet.this[2].id"]
      subnet_ids = [ for subnet in var.az : yandex_vpc_subnet.this[subnet].id ]
      nat = true
    }
    metadata = {
      ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
    }
    service_account_id = yandex_iam_service_account.this.id
  }
  scale_policy {
    fixed_scale {
      size = var.vm_count
    }
  }
  allocation_policy {
    zones = var.az
  }
  application_load_balancer {
    target_group_name = "this"
  }
  deploy_policy {
    max_unavailable = 2
    max_expansion = 2
  }
}