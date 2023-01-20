terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.80"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = ""
  cloud_id  = "b1gp2jrim97lt34uql2c"
  folder_id = "b1g5rgf4frol5fakpmv1"
}

