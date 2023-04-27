variable "devops" {
  default = "devops engineer"
}

output "result" {
  value = var.devops
}

output "who" {
  value = "The Role is ${var.devops} "
}

variable "list" {
  default = [
    100,
    hello,
    10.6,
    true
  ]
}

output "All" {
  value = var.list
}