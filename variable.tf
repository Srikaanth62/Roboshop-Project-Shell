variable "devops" {
  default = "I am devops engineer"
}

output "result" {
  value = var.devops
}

output "who" {
  value = "The Role is = ${var.devops} "
}