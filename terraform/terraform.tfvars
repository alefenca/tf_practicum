resources = {
    disk  = "10"
    memory = "4"
    cpu = "2"
}
cidr_blocks = [
  ["10.10.1.0/24"],
  ["10.10.2.0/24"],
  ["10.10.3.0/24"]
]

vm_count = 3

image_name = "nginx"
image_tag = 1