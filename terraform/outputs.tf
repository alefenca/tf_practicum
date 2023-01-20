output "external_ip_alb" {
#  value = yandex_alb_load_balancer.this.listener[*].[*].address
value = yandex_alb_load_balancer.this.listener[0].endpoint[0].address[0].external_ipv4_address
}
