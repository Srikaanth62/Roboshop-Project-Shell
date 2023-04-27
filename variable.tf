variable "devops" {
  default = "devops engineer"
}

output "result" {
  value = var.devops
}

output "who" {
  value = "The Role is ${var.devops} "
}