resource "yandex_alb_backend_group" "this" {
  name = "alb-backend-group"

  http_backend {
    name             = "nginx-http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_compute_instance_group.this.application_load_balancer.0.target_group_id]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      healthcheck_port = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name   = "ws-http-router"
}

resource "yandex_alb_virtual_host" "this" {
  name           = "virtual-host"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "nginx"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout          = "3s"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name = "alb"

  network_id = yandex_vpc_network.this.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.this["ru-central1-a"].id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.this["ru-central1-b"].id
    }
    location {
      zone_id   = "ru-central1-c"
      subnet_id = yandex_vpc_subnet.this["ru-central1-c"].id
    }
  }

  listener {
    name = "nginx"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }
}